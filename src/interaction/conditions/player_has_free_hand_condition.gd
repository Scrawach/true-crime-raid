class_name PlayerHasEmptyHandCondition
extends InteractionCondition

func can_interact_with(player: PlayerBody3D) -> bool:
	return player.hand.is_empty()
