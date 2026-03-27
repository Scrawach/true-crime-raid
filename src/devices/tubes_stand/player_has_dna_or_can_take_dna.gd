class_name PlayerHasDNAOrCanTakeDNA
extends InteractionCondition

@export var tubes_stand: InteractWithTubesStand

func can_interact_with(player: PlayerBody3D) -> bool:
	var has_dna_item := player.hand.item and player.hand.item is DNAItem
	var can_take_dna := tubes_stand.has_tubes() and player.hand.is_empty()
	return has_dna_item or can_take_dna
