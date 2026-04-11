class_name PlayerMovementState
extends PlayerState

@export var inspect_state: PlayerInspectState
@export var interact_state: PlayerInteractState

@export var hud: PlayerHUD
@export var mouse_capture: MouseCapture
@export var interactor: PlayerInteractor
@export var hand: PlayerHand
@export var sensitivity: float = 0.2

func state_handle_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_capture.is_captured():
		player.head_rotate(-event.relative * sensitivity)
	
	player.move(get_movement_input())
	
	if event is InputEventMouseButton and event.is_pressed() and not mouse_capture.is_captured() and not hud.menu_container.visible:
		mouse_capture.capture()
	elif event.is_action_pressed("escape"):
		if mouse_capture.is_captured():
			hud.menu_container.show()
			mouse_capture.uncapture()
		else:
			hud.menu_container.hide()
			mouse_capture.capture()
	
	if event.is_action_pressed("inspect") and hand.has_item():
		state_machine.switch_to(inspect_state)
	elif event.is_action_pressed("interact"):
		if interactor.can_interact_with_target():
			state_machine.switch_to(interact_state)
		elif hand.has_item():
			hand.drop()

func enter() -> void:
	mouse_capture.capture()

func exit() -> void:
	mouse_capture.uncapture()
	player.move(Vector2.ZERO)

func get_movement_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
