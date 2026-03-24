class_name MouseCapture
extends Node

@export var player_input: PlayerInput

var _is_captured: bool

func _physics_process(_delta: float) -> void:
	if _is_captured and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		## WEB workaround (browser handle inputs)
		uncapture()

func is_captured() -> bool:
	return _is_captured

func capture() -> void:
	_is_captured = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func hide_cursor():
	_is_captured = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func uncapture() -> void:
	_is_captured = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
