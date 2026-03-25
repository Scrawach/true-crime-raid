class_name VisiblePointOnCameraWithSize
extends VisiblePointOnCamera

@export var is_small_point: bool
@export var visible_distance: float = 0.4

func is_visible_to_camera(camera: Camera3D) -> bool:
	if is_small_point and not is_close_enough(camera):
		return false
	return super.is_visible_to_camera(camera)

func is_close_enough(camera: Camera3D) -> bool:
	var distance = camera.global_position.distance_to(global_position)
	return distance < visible_distance
