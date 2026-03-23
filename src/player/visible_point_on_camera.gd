class_name VisiblePointOnCamera
extends Node3D

signal screen_entered()
signal screen_exited()

@export_flags_3d_physics var collision_layer: int

var camera_node: Camera3D
var is_visible_on_screen: bool = false

func enable() -> void:
	camera_node = get_viewport().get_camera_3d()
	if camera_node == null:
		set_process(false)
	else:
		set_process(true)

func disable() -> void:
	set_process(false)
	screen_exited.emit()
	is_visible_on_screen = false

func is_visible_to_camera(camera: Camera3D) -> bool:
	var obstacles := get_obstacle_between(camera.global_position, global_position)
	return obstacles.is_empty()

func get_obstacle_between(start_point: Vector3, target_point: Vector3) -> Dictionary:
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(start_point, target_point)
	query.collide_with_bodies = true
	query.collision_mask = collision_layer
	return space_state.intersect_ray(query)

func _process(_delta: float) -> void:
	var is_visible_now = is_visible_to_camera(camera_node)
	
	if is_visible_now != is_visible_on_screen:
		is_visible_on_screen = is_visible_now
		
		if is_visible_on_screen:
			screen_entered.emit()
		else:
			screen_exited.emit()
	
