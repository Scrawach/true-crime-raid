class_name PlayerInspectState
extends PlayerState

@export var movement_state: PlayerMovementState

@export var inspect_scene: InspectItem

func state_handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("inspect") or event.is_action_pressed("escape"):
		state_machine.switch_to(movement_state)

func enter() -> void:
	inspect_scene.player = player
	inspect_scene.inspect(player.hand.item)

func exit() -> void:
	player.hand.item = inspect_scene.item
	player.hand.item.reparent(player.hand.hand_point)
	player.hand.item.position = Vector3.ZERO
	player.hand.item.rotation = Vector3.ZERO
	inspect_scene.abort()
