class_name PlayerHasDNAItemInHandCondition
extends InteractionCondition

func can_interact_with(player: PlayerBody3D) -> bool:
	return player.hand.has_item() and player.hand.item is DNAItem
