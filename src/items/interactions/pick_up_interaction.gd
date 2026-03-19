class_name PickUpInteraction
extends Node

@export var body: RigidBody3D
@export var interaction_area_3d: InteractionArea3D

func _ready() -> void:
	interaction_area_3d.interacted.connect(_on_interacted)

func _on_interacted(player: PlayerBody3D) -> void:
	body.freeze = true
	player.hand.pickup(body)
