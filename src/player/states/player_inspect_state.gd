class_name PlayerInspectState
extends PlayerState

@export var movement_state: PlayerMovementState
@export var inspect_scene: InspectItem
@export var mouse_capture: MouseCapture

var is_animating: bool = false

func state_handle_input(event: InputEvent) -> void:
	if is_animating:
		return
	
	if is_quit_inspect_pressed(event):
		deffered_switch_to_movement_state()

func enter() -> void:
	is_animating = true
	inspect_scene.player = player
	inspect_scene.item = player.hand.item
	inspect_scene.smooth_show(_on_enter)
	player.hand.item.reparent(inspect_scene.item_point)
	smooth_move_item_to_zero(player.hand.item, 0.2)

func _on_enter() -> void:
	inspect_scene.inspect(player.hand.item)
	is_animating = false

func deffered_switch_to_movement_state() -> void:
	mouse_capture.capture()
	is_animating = true
	inspect_scene.smooth_hide(_on_inspect_abort)
	player.hand.item.reparent(player.hand.hand_point)
	smooth_move_item_to_zero(player.hand.item, 0.15)

func _on_inspect_abort() -> void:
	player.hand.item = inspect_scene.item
	player.hand.item.reparent(player.hand.hand_point)
	player.hand.item.position = Vector3.ZERO
	player.hand.item.rotation = Vector3.ZERO
	inspect_scene.abort()
	
	is_animating = false
	state_machine.switch_to(movement_state)

func smooth_move_item_to_zero(target: BaseItem, duration: float) -> Tween:
	var tween := create_tween()
	tween.tween_property(target, "position", Vector3.ZERO, duration)
	tween.parallel().tween_property(target, "rotation", Vector3.ZERO, duration)
	return tween

func smooth_move_item_to_target(item: BaseItem, target: Node3D, duration: float) -> Tween:
	var tween := create_tween()
	tween.tween_property(item, "position",target.position, duration)
	tween.parallel().tween_property(item, "rotation", target.rotation, duration)
	return tween

func is_quit_inspect_pressed(event: InputEvent) -> bool:
	return event.is_action_pressed("inspect") or event.is_action_pressed("escape")
