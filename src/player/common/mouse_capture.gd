class_name MouseCapture
extends Node

var _is_captured: bool

## Timer required, because WEB can't
## immidently update cursor mode
var _timer: Timer
var _operation: Callable

func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = false
	add_child(_timer)
	_timer.timeout.connect(_on_timeout)
	_timer.start(0.1)

func _on_timeout() -> void:
	_operation.call()

func _physics_process(_delta: float) -> void:
	if _is_captured and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		## WEB workaround (browser handle inputs)
		uncapture()

func is_captured() -> bool:
	return _is_captured

func capture() -> void:
	_operation = func():
		_is_captured = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func hide_cursor():
	_operation = func():
		_is_captured = true
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func uncapture() -> void:
	_operation = func():
		_is_captured = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
