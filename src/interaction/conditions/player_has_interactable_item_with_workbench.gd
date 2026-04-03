class_name PlayerHasInteractableItemWithWorkbench
extends InteractionCondition

func can_interact_with(player: PlayerBody3D) -> bool:
	if not player.hand.has_item():
		return false
	
	return player.hand.item.data and player.hand.item.data.can_interact_with_workbench
