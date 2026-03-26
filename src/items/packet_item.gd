class_name PacketItem
extends BaseItem

@export var open_item: BaseItem
@export var open_point: OpenInteractivePoint3D

func _ready() -> void:
	if open_item:
		initialize(open_item)

func initialize(new_item_scene: BaseItem) -> void:
	open_point.open_item = new_item_scene
