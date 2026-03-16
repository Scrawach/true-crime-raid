class_name MouseCapture
extends Node

@export var player_input: PlayerInput

var _is_captured: bool

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not is_captured():
		capture()
	if event.is_action_pressed("escape"):
		uncapture()

func _physics_process(_delta: float) -> void:
	if _is_captured and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		## WEB workaround (browser handle inputs)
		uncapture()

func is_captured() -> bool:
	return _is_captured

func capture() -> void:
	_is_captured = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_input.is_enabled = true

func uncapture() -> void:
	_is_captured = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player_input.is_enabled = false
