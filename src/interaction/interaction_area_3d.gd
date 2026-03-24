class_name InteractionArea3D
extends Area3D

@export var conditions: Array[InteractionCondition]

signal hovered()
signal interacted(player: PlayerBody3D)
signal unhovered()

signal disabled()
signal enabled()

var prev_collision_layer: int
var prev_collision_mask: int

func _ready() -> void:
	prev_collision_layer = collision_layer
	prev_collision_mask = collision_mask

func can_interact_with(player: PlayerBody3D) -> bool:
	if conditions.is_empty():
		return true
	
	for condition in conditions:
		if condition.can_interact_with(player):
			return true
	return false

func hover() -> void:
	hovered.emit()

func interact(player: PlayerBody3D) -> void:
	interacted.emit(player)

func unhover() -> void:
	unhovered.emit()

func enable() -> void:
	collision_layer = prev_collision_layer
	collision_mask = prev_collision_layer
	enabled.emit()

func disable() -> void:
	prev_collision_layer = collision_layer
	prev_collision_mask = collision_mask
	
	collision_layer = 0
	collision_mask = 0
	disabled.emit()
