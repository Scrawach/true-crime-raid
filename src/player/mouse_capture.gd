class_name MouseCapture
extends Node

@export var player_input: PlayerInput
@export var is_captured_on_ready: bool = true

func _ready() -> void:
	if is_captured_on_ready:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		switch_mouse_capture_mode()

func switch_mouse_capture_mode() -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		player_input.is_enabled = true
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		player_input.is_enabled = false
