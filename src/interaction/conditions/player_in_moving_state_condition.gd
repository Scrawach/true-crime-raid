class_name PlayerInMovingStateCondition
extends InteractionCondition

func can_interact_with(player: PlayerBody3D) -> bool:
	return player.state_machine.current_state is PlayerMovementState
