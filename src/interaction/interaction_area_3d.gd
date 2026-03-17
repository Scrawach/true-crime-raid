class_name InteractionArea3D
extends Area3D

signal hovered()
signal interacted(player: PlayerBody3D)
signal unhovered()

var prev_collision_layer: int
var prev_collision_mask: int

func _ready() -> void:
	prev_collision_layer = collision_layer
	prev_collision_mask = collision_mask

func hover() -> void:
	hovered.emit()

func interact(player: PlayerBody3D) -> void:
	interacted.emit(player)

func unhover() -> void:
	unhovered.emit()

func enable() -> void:
	collision_layer = prev_collision_layer
	collision_mask = prev_collision_layer

func disable() -> void:
	prev_collision_layer = collision_layer
	prev_collision_mask = collision_mask
	
	collision_layer = 0
	collision_mask = 0
