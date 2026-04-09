class_name WorkbenchPlacementSpace
extends Node3D

@export var rotation_height_ratio: float = 4.0
@onready var items_handler: Node3D = $"Items Handler"

func put(item: BaseItem) -> void:
	## TODO: placement algorithm used AABB from items
	var aabb := item.get_aabb()
	var height_ratio := aabb.size.y / aabb.size.x
	if height_ratio > rotation_height_ratio:
		item.rotation_degrees.x = 90
	
	var parent := get_free_position_for()
	var new_parent := parent if parent != null else items_handler
	item.reparent(new_parent)
	item.position = Vector3.UP / 2
	item.ungrab()

func get_free_position_for() -> Node3D:
	for child in items_handler.get_children():
		if child.get_child_count() == 0:
			return child
	return null
