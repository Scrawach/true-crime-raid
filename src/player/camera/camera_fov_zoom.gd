class_name CameraFOVZoom
extends CameraZoom

@export var min_fov: float = 10
@export var max_fov: float = 75

var desired_fov: float

func _ready() -> void:
	desired_fov = camera.fov

func disable() -> void:
	super.disable()
	desired_fov = max_fov

func get_zoom_ratio() -> float:
	return (camera.fov - min_fov) / (max_fov - min_fov)

func _process(delta: float) -> void:
	desired_fov = clampf(desired_fov + zoom_relative, min_fov, max_fov)
	var fov_step := desired_fov - camera.fov
	camera.fov += fov_step * delta * scroll_speed
	zoom_relative = 0
