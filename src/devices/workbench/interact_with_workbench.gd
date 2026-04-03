class_name InteractWithWorkbench
extends InteractWithDevice

@export var uv_lamp: UVLamp
@export var item_handler: ItemHandler

var item: BaseItem

func _ready() -> void:
	uv_lamp.changed.connect(_on_uv_lamp_changed)

func start_interaction(target: PlayerBody3D) -> void:
	super.start_interaction(target)
	item_handler.clear()
	uv_lamp.enable()
	grab(target.hand.item)
	
func stop_interaction() -> void:
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
