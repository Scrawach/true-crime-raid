class_name PlayerHand
extends Node

@export var body: PlayerBody3D
@export var hud: PlayerHUD
@export var hand_point: Node3D
@export var head: Node3D
@export var pickup_duration: float = 0.2

@export var throw_strength: float = 1.5
@export var velocity_strength: float = 0.1

var item: BaseItem
var tween: Tween

var is_item_on_hand: bool

func has_item() -> bool:
	return not is_empty() and is_item_on_hand

func is_empty() -> bool:
	return item == null

func pickup(object: BaseItem) -> void:
	item = object
	item.grab()
	object.reparent(hand_point)
	
	tween = create_tween()
	tween.tween_method(_move_to_hand, 0.0, 1.0, pickup_duration)
	tween.tween_callback(func():
		hud.show_item_handle_tooltip()
		is_item_on_hand = true)

func drop() -> void:
	_kill_if_needed()
	is_item_on_hand = false
	hud.hide_item_handle_tooltip()
	item.reparent(body.get_parent())
	item.ungrab()
	item.apply_force(get_drop_force())
	item.apply_torque(item.basis * Vector3.LEFT)
	item = null

func _move_to_hand(progress: float) -> void:
	if not item:
		return
	item.position = lerp(item.position, Vector3.ZERO, progress)
	item.rotation = lerp(item.rotation, Vector3.ZERO, progress)

func _kill_if_needed() -> void:
	if tween:
		tween.custom_step(9999)
		tween.kill()

func get_drop_force() -> Vector3:
	const THROW_STRENGTH_MIN := 125
	const THROW_STRENGTH_MAX := 140
	var offset := randf_range(-.25, .15)
	var direction := head.global_basis * Vector3(offset, 0, -1.5) + Vector3.UP
	var velocity := body.velocity.length() * velocity_strength
	return direction * (throw_strength + velocity) * randf_range(THROW_STRENGTH_MIN, THROW_STRENGTH_MAX)
