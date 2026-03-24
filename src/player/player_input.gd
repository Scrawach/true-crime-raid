class_name PlayerInput
extends Node

@export var body: PlayerBody3D
@export var interactor: PlayerInteractor
@export var hand: PlayerHand

@export var mouse_capture: MouseCapture
@export var sensitivity: float = 0.2
@export var is_enabled: bool = true

func _input(event: InputEvent) -> void:
	if not is_enabled:
		return
	
	if not is_instance_valid(body):
		return
	
	if not mouse_capture.is_captured():
		return
	
	_process_input(event)

func enable() -> void:
	is_enabled = true

func disable() -> void:
	is_enabled = false

func _process_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if interactor.can_interact_with_target():
			interactor.try_interact()
		elif hand.has_item():
			hand.drop()
	
	if event is InputEventMouseMotion:
		body.head_rotate(-event.relative * sensitivity)
	
	body.move(get_movement_input())

func get_movement_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
