class_name PlayerHand
extends Node

@export var body: Node3D
@export var hud: PlayerHUD
@export var hand_point: Node3D
@export var head: Node3D
@export var pickup_duration: float = 0.2

var item: BaseItem
var tween: Tween

func has_item() -> bool:
	return item != null

func pickup(object: BaseItem) -> void:
	item = object
	item.grab()
	object.reparent(hand_point)
	
	tween = create_tween()
	tween.tween_method(_move_to_hand, 0.0, 1.0, pickup_duration)
	tween.tween_callback(hud.show_item_handle_tooltip)

func drop() -> void:
	_kill_if_needed()
	
	hud.hide_item_handle_tooltip()
	item.reparent(body.get_parent())
	item.ungrab()
	item.apply_force(get_drop_force())
	item = null

func _move_to_hand(progress: float) -> void:
	item.global_position = lerp(item.global_position, hand_point.global_position, progress)
	item.rotation = lerp(item.rotation, hand_point.rotation, progress)

func _kill_if_needed() -> void:
	if tween:
		tween.kill()

func get_drop_force() -> Vector3:
	const THROW_STRENGTH_MIN := 100
	const THROW_STRENGTH_MAX := 150
	var offset := randf_range(-.5, .3)
	var direction := head.global_basis * Vector3(offset, 0, -1.5) + Vector3.UP
	return direction * randf_range(THROW_STRENGTH_MIN, THROW_STRENGTH_MAX)
