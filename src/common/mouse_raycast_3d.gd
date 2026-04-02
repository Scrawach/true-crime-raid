class_name MouseRaycast3D
extends Node3D

const RAY_LENGTH := 100

@export var zoom: CameraZoom
@export_flags_3d_physics var target_layer: int
@export_flags_3d_physics var small_target_layer: int
@export var collide_with_areas: bool
@export var collide_with_bodies: bool

var prev_interacted_body: ClickableArea3D
var main_camera: Camera3D

func _ready() -> void:
	main_camera = get_viewport().get_camera_3d()

func make_cast(camera: Camera3D) -> Dictionary:
	var mouse_position := get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	var space := get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = target_layer
	
	if zoom and zoom.is_small_enough():
		query.collision_mask |= small_target_layer
	
	query.collide_with_areas = collide_with_areas
	query.collide_with_bodies = collide_with_bodies
	return space.intersect_ray(query)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if prev_interacted_body:
			prev_interacted_body.click()

func _physics_process(_delta: float) -> void:
	var result := make_cast(main_camera)
	if result.is_empty():
		if prev_interacted_body:
			prev_interacted_body.unhover()
			prev_interacted_body = null
		return
	
	var collider = result["collider"]
	
	if not collider is ClickableArea3D:
		return
	
	if prev_interacted_body == collider:
		return
	
	prev_interacted_body = collider
	prev_interacted_body.hover()
