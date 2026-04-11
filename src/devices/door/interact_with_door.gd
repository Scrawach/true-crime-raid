class_name InteractWithDoor
extends Node

@export var area: InteractionArea3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area.interacted.connect(_on_interacted)

func _on_interacted(_player: PlayerBody3D) -> void:
	animation_player.play("try_open")
