class_name PlayerHasUnpackedItemCondition
extends InteractionCondition

func can_interact_with(player: PlayerBody3D) -> bool:
	if not player.hand.has_item():
		return false
	
	return not player.hand.item is PacketItem
