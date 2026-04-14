class_name InspectItem
extends Node3D

signal inspect_started(target: BaseItem)

@export var player: PlayerBody3D
@export var player_hand: PlayerHand
@export var dna_tube: PackedScene
@export var trash_item: PackedScene

@onready var inspect_scene_appear: InspectSceneAppear = %InspectSceneAppear
@onready var item_handler: InspectorItemHandler = %"Item Handler"

@onready var item_point: Marker3D = %"Item Point"
@onready var canvas_layer: CanvasLayer = $CanvasLayer

@onready var camera_zoom: CameraZoom = %CameraZoom
@onready var inspector_control: InspectorControl = %"Inspector Control"

@onready var woosh_audio_player: AudioStreamPlayer = %"Woosh AudioPlayer"

var item: BaseItem
var is_interruptable: bool = true

func smooth_show(callback: Callable = Callable()) -> void:
	item_handler.clear()
	item = player.hand.item
	inspect_scene_appear.smooth_show(func():
		inspect(player.hand.item)
		if callback:
			callback.call())
	inspector_control.initialize(item)
	player.hand.item.reparent(item_point)
	smooth_move_item_to_zero(player.hand.item, 0.2)
	woosh_audio_player.play()

func smooth_hide(callback: Callable = Callable()) -> void:
	inspect_scene_appear.smooth_hide(func():
		player.hand.item = item
		player.hand.item.reparent(player.hand.hand_point)
		player.hand.item.position = Vector3.ZERO
		player.hand.item.rotation = Vector3.ZERO
		abort()
		if callback:
			callback.call())
	inspector_control.clear()
	item_handler.stop_rotation()
	player.hand.item.reparent(player.hand.hand_point)
	smooth_move_item_to_zero(player.hand.item, 0.15)
	woosh_audio_player.play()

func smooth_move_item_to_zero(target: BaseItem, duration: float) -> Tween:
	var tween := create_tween()
	tween.tween_property(target, "position", Vector3.ZERO, duration)
	tween.parallel().tween_property(target, "rotation", Vector3.ZERO, duration)
	return tween

func inspect(target: BaseItem) -> void:
	camera_zoom.enable()
	canvas_layer.show()
	inspector_control.clear()
	
	item = target
	item_handler.stop_rotation()
	target.reparent(item_point)
	target.position = Vector3.ZERO
	target.rotation = Vector3.ZERO
	
	var points := target.get_interactive_points()
	for point in points.get_children():
		if point is OpenInteractivePoint3D:
			point.enable()
	points.clicked.connect(_on_clicked)
	
	if item.data:
		for keyword in item.data.auto_picked_in_inspect:
			keyword.pickup()
	
	set_process_input(true)
	inspector_control.initialize(item)
	inspect_started.emit(item)
	
func abort() -> void:
	camera_zoom.disable()
	camera_zoom.clear()
	
	var points := item.get_interactive_points()
	for point in points.get_children():
		if point is OpenInteractivePoint3D:
			point.disable()
	points.clicked.disconnect(_on_clicked)
	
	set_process_input(false)

func can_interupt() -> bool:
	return is_interruptable

func set_interruptable(new_value: bool) -> void:
	is_interruptable = new_value

func _on_clicked(point: InteractivePoint3D) -> void:
	if point is KeywordInteractivePoint3D:
		_process_keyword(point)
	elif point is OpenInteractivePoint3D:
		_process_open(point)
	elif point is DNAInteractivePoint3D:
		_process_dna_open(point)

func _process_open(point: OpenInteractivePoint3D) -> void:
	var spawn_object := point.open_item
	if spawn_object.get_parent() == null:
		add_sibling(spawn_object)
	else:
		spawn_object.reparent(get_parent())
	spawn_object.grab()
	item.queue_free()
	player.hand.item = spawn_object
	abort()
	inspect(spawn_object)
	
	var trash := trash_item.instantiate() as Node3D
	player.add_sibling(trash)
	trash.global_position = spawn_object.global_position

func _process_dna_open(point: DNAInteractivePoint3D) -> void:
	## TODO: REFACTOR THIS SHIT
	var data = point.dna_data
	var tube := dna_tube.instantiate() as DNAItem
	add_sibling(tube)
	tube.grab()
	
	tube.dna_data = data
	item.reparent(player.get_parent())
	item.ungrab()
	abort()
	inspect(tube)
	
	player.hand.item = item
	#player.hand.drop()
	#player.hand.pickup(tube)

func _process_keyword(point: KeywordInteractivePoint3D) -> void:
	inspector_control.add_keyword(point, point.data)
