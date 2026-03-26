class_name CameraDistanceZoom
extends CameraZoom

@export var min_distance: float = -0.4
@export var max_distance: float = 0.0

var desired_distance: float

func _ready() -> void:
	desired_distance = max_distance

func disable() -> void:
	super.disable()

func clear() -> void:
	desired_distance = max_distance

func get_zoom_ratio() -> float:
	var ratio := (camera.position.z - min_distance) / (max_distance - min_distance)
	return ratio

func _process(delta: float) -> void:
	desired_distance = clampf(desired_distance + zoom_relative, min_distance, max_distance)
	var distance_step := desired_distance - camera.position.z
	camera.position.z += distance_step * delta * scroll_speed
	zoom_relative = 0
