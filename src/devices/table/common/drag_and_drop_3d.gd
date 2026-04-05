class_name DragAndDrop3D
extends Node3D

const RAY_LENGTH := 100

@export_flags_3d_physics var target_layer: int
@export var collide_with_areas: bool
@export var collide_with_bodies: bool

@export var hand: StickerHand
@export var table_raycast: RayCast3D

@export var hover_mesh: Node3D
@export var hover_mesh_path: Node3D

@export var table_stickers: TableStickers

var dragging_body: Sticker
var dragging_body_offset: Vector3

var is_dragging: bool
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
	query.collide_with_areas = collide_with_areas
	query.collide_with_bodies = collide_with_bodies
	return space.intersect_ray(query)

func get_mouse_position_in_world_3d() -> Vector3:
	var mouse_position = get_viewport().get_mouse_position()
	var depth =  hand.global_position.x - main_camera.global_position.x;
	return main_camera.project_position(mouse_position, depth)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_dragging:
		_drag()
		return
	
	if not event is InputEventMouseButton:
		return
	
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if event.is_pressed():
		_start_drag()
	elif event.is_released() and is_dragging:
		_end_drag()

func _start_drag() -> void:
	var result := make_cast(main_camera)
	if result.is_empty():
		return
	
	var collider = result["collider"]
	
	if not collider is Sticker:
		return
	
	if table_stickers.has(collider):
		table_stickers.remove(collider)
		collider.reparent(hand)
	
	dragging_body = collider
	dragging_body_offset = dragging_body.global_position - result["position"]
	
	is_dragging = true
	var target := get_mouse_position_in_world_3d()
	dragging_body.global_position = target + dragging_body_offset
	
	_update_hover_position()
	var distance := dragging_body.global_position.distance_to(hover_mesh.global_position)
	hover_mesh_path.scale.y = distance

func _drag() -> void:
	_update_hover_position()
	var target := get_mouse_position_in_world_3d()
	dragging_body.global_position = target + dragging_body_offset

func _end_drag() -> void:
	is_dragging = false
	if table_raycast.is_colliding():
		dragging_body.global_position = table_raycast.get_collision_point()
		table_stickers.append(dragging_body)
		dragging_body = null
	hover_mesh.hide()
	pass

func _update_hover_position() -> void:
	table_raycast.global_position = dragging_body.global_position
	table_raycast.force_update_transform()
	table_raycast.force_raycast_update()
	
	if table_raycast.is_colliding():
		hover_mesh.global_position = table_raycast.get_collision_point()
		hover_mesh.show()
	else:
		hover_mesh.hide()
