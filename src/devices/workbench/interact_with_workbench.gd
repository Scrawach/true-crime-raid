class_name InteractWithWorkbench
extends InteractWithDevice

signal sample_taked(data: DNAData)

@export var dna_tube_scene: PackedScene

@export var uv_lamp: UVLamp
@export var item_handler: ItemHandler
@export var tubes: InteractWithTubesStand
@export var item_zoom: ItemZoom

@export var sample_timed_panel: TimedPanel

var item: BaseItem

func _ready() -> void:
	uv_lamp.changed.connect(_on_uv_lamp_changed)

func start_interaction(target: PlayerBody3D) -> void:
	super.start_interaction(target)
	item_handler.clear()
	uv_lamp.enable()
	grab(target.hand.item)
	subscribe_on_dna_points()
	item_zoom.enable()
	
func stop_interaction() -> void:
	item_zoom.clear()
	item_zoom.disable()
	unsubscribe_from_dna_points()
	uv_lamp.disable()
	ungrab(item)
	item_handler.clear()
	super.stop_interaction()

func grab(target: BaseItem) -> void:
	item = target
	target.reparent(item_handler)
	target.position = Vector3.ZERO
	target.rotation = Vector3.ZERO

func ungrab(target: BaseItem) -> void:
	item.reparent(player.hand.hand_point)
	target.position = Vector3.ZERO
	target.rotation = Vector3.ZERO

func subscribe_on_dna_points() -> void:
	for point in item.get_dna_interactive_points():
		point.clicked.connect(_on_dna_clicked)

func unsubscribe_from_dna_points() -> void:
	for point in item.get_dna_interactive_points():
		point.clicked.disconnect(_on_dna_clicked)

func _on_dna_clicked(point: DNAInteractivePoint3D) -> void:
	sample_timed_panel.timed_show()
	var dna_tube := dna_tube_scene.instantiate() as DNAItem
	add_child(dna_tube)
	dna_tube.dna_data = point.dna_data
	sample_taked.emit(point.dna_data)
	tubes.put_dna(dna_tube)

func _on_uv_lamp_changed(is_active: bool) -> void:
	for point in item.get_interactive_points().get_children():
		if point is DNAInteractivePoint3D:
			_process_dna_point(point, is_active)

func _process_dna_point(point: DNAInteractivePoint3D, is_uv_active: bool) -> void:
	if not point.uv_required:
		return
	
	if is_uv_active:
		point.uv_enable()
		point.enable()
	else:
		point.uv_disable()
		point.disable()
