class_name PlayerInteractor
extends Node

@export var player: PlayerBody3D
@export var raycast_3d: RayCast3D
@export var max_distance: float = 2.0

var interaction: InteractionArea3D

func _physics_process(_delta: float) -> void:
	if not raycast_3d.is_colliding():
		_stop_interaction()
		return
	
	var target := raycast_3d.get_collider()
	
	if not target is InteractionArea3D:
		_stop_interaction()
		return
	
	_start_interaction(target as InteractionArea3D)

func can_interact_with_target() -> bool:
	if interaction == null:
		return false
	return interaction.can_interact_with(player)

func _start_interaction(target: InteractionArea3D) -> void:
	if interaction == target:
		return
	
	if interaction != null:
		interaction.unhover()
		interaction = null
	
	if not target.can_interact_with(player):
		return
	
	interaction = target
	interaction.hover()

func _stop_interaction() -> void:
	if interaction:
		interaction.unhover()
	interaction = null

func try_interact() -> bool:
	if interaction:
		interaction.interact(player)
	return interaction != null
