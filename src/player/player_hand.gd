class_name PlayerHand
extends Node

@export var body: Node3D
@export var hud: PlayerHUD
@export var hand_point: Node3D

var item: BaseItem

func has_item() -> bool:
	return item != null

func pickup(object: BaseItem) -> void:
	item = object
	object.reparent(hand_point)
	object.global_position = hand_point.global_position
	object.rotation = hand_point.rotation
	hud.show_item_handle_tooltip()

func drop() -> void:
	hud.hide_item_handle_tooltip()
	item.reparent(body.get_parent())
	item.freeze = false
	item.apply_force(get_drop_force())
	item = null

func get_drop_force() -> Vector3:
	return body.basis * Vector3(randf_range(-.5, .5), randf_range(1.5, 2.0), -1) * 150
