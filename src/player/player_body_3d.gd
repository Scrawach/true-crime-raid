class_name PlayerBody3D
extends CharacterBody3D

@export var head: Node3D
@export var movement_speed: float = 5.0

var _moving_direction: Vector2
var _gaze_direction: Vector2

func move(direction: Vector2) -> void:
	_moving_direction = direction

func head_rotate(direction: Vector2) -> void:
	_gaze_direction = direction

func _physics_process(delta: float) -> void:
	_movement_process(delta)
	_rotate_process(delta)
	move_and_slide()

func _movement_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var movement := (transform.basis * Vector3(_moving_direction.x, 0, _moving_direction.y).normalized())
	if movement:
		velocity.x = movement.x * movement_speed
		velocity.z = movement.z * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		velocity.z = move_toward(velocity.z, 0, movement_speed)

func _rotate_process(delta: float) -> void:
	if _gaze_direction.is_zero_approx():
		return
	rotate_y(_gaze_direction.x * delta)
	head.rotate_x(_gaze_direction.y * delta)
	head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)
	_gaze_direction = Vector2.ZERO
