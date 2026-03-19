class_name PlayerHand
extends Node

@export var body: Node3D
@export var hud: PlayerHUD
@export var hand_point: Node3D
@export var head: Node3D

var item: BaseItem

func has_item() -> bool:
	return item != null

func pickup(object: BaseItem) -> void:
	item = object
	item.grab()
	object.reparent(hand_point)
	object.global_position = hand_point.global_position
	object.rotation = hand_point.rotation
	hud.show_item_handle_tooltip()

func drop() -> void:
	hud.hide_item_handle_tooltip()
	item.reparent(body.get_parent())
	item.ungrab()
	item.apply_force(get_drop_force())
	item = null

func get_drop_force() -> Vector3:
	const THROW_STRENGTH_MIN := 100
	const THROW_STRENGTH_MAX := 150
	var offset := randf_range(-.5, .3)
	var direction := head.global_basis * Vector3(offset, 0, -1.5) + Vector3.UP
	return direction * randf_range(THROW_STRENGTH_MIN, THROW_STRENGTH_MAX)
