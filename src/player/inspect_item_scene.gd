class_name InspectItem
extends Node3D

@export var dna_tube: PackedScene

@onready var control_container: Control = %"Control Container"

@onready var sub_viewport: SubViewport = %SubViewport
@onready var sub_viewport_container: SubViewportContainer = %SubViewportContainer
@onready var item_camera_3d: Camera3D = %"Item Camera3D"

@onready var keywords_panel: PanelContainer = %"Keywords Panel"
@onready var keywords_count: Label = %"Keywords Count"
@onready var keywords_container: HBoxContainer = %"Keywords Container"
@onready var item_handler: InspectorItemHandler = %"Item Handler"

@onready var item_point: Marker3D = %"Item Point"
@onready var canvas_layer: CanvasLayer = $CanvasLayer

@onready var keyword_description: KeywordDescription = %"Keyword Description"

var found_keywords: Dictionary[String, KeywordData]

var item: BaseItem
var player: PlayerBody3D

func _ready() -> void:
	keyword_description.keyword_clicked.connect(_on_keyword_clicked)

func inspect(target: BaseItem) -> void:
	_update_item_description(target)
	canvas_layer.show()
	clear_keywords()
	
	item = target
	item_handler.stop_rotation()
	target.reparent(item_point)
	target.position = Vector3.ZERO
	target.rotation = Vector3.ZERO
	
	var points := target.get_interactive_points()
	points.enable()
	points.clicked.connect(_on_clicked)
	
	_update_keyword_counts()
	if keyword_description.get_keyword_count() == 0:
		keywords_panel.hide()
	else:
		keywords_panel.show()
	set_process_input(true)

func _update_item_description(target: BaseItem) -> void:
	if target.data == null:
		keyword_description.initialize("", "")
		keyword_description.hide()
		return
	keyword_description.show()
	keyword_description.initialize(target.data.name, target.get_description())

func abort() -> void:
	canvas_layer.hide()
	
	var points := item.get_interactive_points()
	points.disable()
	points.clicked.disconnect(_on_clicked)
	
	set_process_input(false)

func _on_keyword_clicked(data: KeywordData) -> void:
	_add_keyword(data)

func _on_clicked(point: InteractivePoint3D) -> void:
	if point is KeywordInteractivePoint3D:
		_process_keyword(point)
	elif point is OpenInteractivePoint3D:
		_process_open(point)
	elif point is DNAInteractivePoint3D:
		_process_dna_open(point)

func _process_open(point: OpenInteractivePoint3D) -> void:
	var spawn_object := point.open_item.instantiate() as BaseItem
	add_sibling(spawn_object)
	spawn_object.grab()
	item.queue_free()
	player.hand.item = spawn_object
	abort()
	inspect(spawn_object)

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
	#player.hand.drop()
	#player.hand.pickup(tube)

func _process_keyword(point: KeywordInteractivePoint3D) -> void:
	spawn_smooth_label(point.data, _get_screen_position(point.global_position))
	_add_keyword(point.data)

func _add_keyword(data: KeywordData) -> void:
	if found_keywords.has(data.id):
		return
	
	found_keywords[data.id] = data
	_update_keyword_counts()
	var flow_label := make_label_for(data)
	keywords_container.add_child(flow_label)
	GameManager.update_keywords(found_keywords)

func _update_keyword_counts() -> void:
	keywords_count.text = "%s / %s" % [found_keywords.size(), get_max_keyword_count()]

func _get_screen_position(pos_3d: Vector3) -> Vector2:
	return sub_viewport_container.global_position + item_camera_3d.unproject_position(pos_3d)

func spawn_smooth_label(keyword: KeywordData, pos: Vector2) -> void:
	var key_label := make_label_for(keyword)
	control_container.add_child(key_label)
	var rect = key_label.get_rect()
	key_label.position = pos - rect.size / 2
	var tween = key_label.create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(key_label, "position", key_label.position + Vector2.UP * 50, 1.0)
	tween.parallel().tween_property(key_label, "modulate:a", 0, 2)
	tween.tween_callback(key_label.queue_free)

func get_max_keyword_count() -> int:
	var sum := 0
	for child in item.get_interactive_points().get_children():
		if child is KeywordInteractivePoint3D:
			sum += 1
	return sum + keyword_description.get_keyword_count()

func clear_keywords() -> void:
	found_keywords.clear()
	for child in keywords_container.get_children():
		child.queue_free()

func make_label_for(keyword: KeywordData) -> Label:
	var key_label := Label.new()
	key_label.uppercase = true
	key_label.text = keyword.words
	return key_label
