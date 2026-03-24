class_name PlayerHasItemCondition
extends InteractionCondition

func can_interact_with(player: PlayerBody3D) -> bool:
	return player.hand.has_item()
