class_name InteractWithWorkbench
extends InteractWithDevice

@export var uv_lamp: UVLamp
@export var item_handler: ItemHandler

var item: BaseItem

func start_interaction(target: PlayerBody3D) -> void:
	super.start_interaction(target)
	uv_lamp.enable()
	grab(player.hand.item)
	
func stop_interaction() -> void:
	uv_lamp.disable()
	ungrab(item)
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
