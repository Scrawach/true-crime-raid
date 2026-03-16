class_name PlayerInput
extends Node

@export var body: PlayerBody3D
@export var sensitivity: float = 0.2
@export var is_enabled: bool = true

func _unhandled_input(event: InputEvent) -> void:
	if not is_enabled:
		return
	
	if not is_instance_valid(body):
		return
	
	_process_input(event)

func _process_input(event: InputEvent) -> void:	
	if event is InputEventMouseMotion:
		body.head_rotate(-event.relative * sensitivity)
	
	body.move(get_movement_input())

func get_movement_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
