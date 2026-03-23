class_name PacketItem
extends BaseItem

@export var open_item: PackedScene
@export var open_point: OpenInteractivePoint3D

func _ready() -> void:
	open_point.open_item = open_item
