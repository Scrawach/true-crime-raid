class_name PlayerInspectState
extends PlayerState

@export var player_hud: PlayerHUD
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
	inspect_scene.smooth_show(_on_enter)
	player_hud.hide_item_handle_tooltip()

func _on_enter() -> void:
	is_animating = false

func deffered_switch_to_movement_state() -> void:
	mouse_capture.capture()
	is_animating = true
	inspect_scene.smooth_hide(_on_inspect_abort)

func _on_inspect_abort() -> void:
	is_animating = false
	state_machine.switch_to(movement_state)
	player_hud.show_item_handle_tooltip()

func is_quit_inspect_pressed(event: InputEvent) -> bool:
	return event.is_action_pressed("inspect") or event.is_action_pressed("escape")
