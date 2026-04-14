class_name Box
extends Node3D

signal opened(box: Box, spawned_object: Node3D)

@export var spawn_scene: PackedScene
@export var spawn_sound: AudioStream
@export var volume_db: float

@onready var interaction_area_3d: InteractionArea3D = %InteractionArea3D

func _ready() -> void:
	interaction_area_3d.interacted.connect(_on_interacted)

func _on_interacted(_player: PlayerBody3D) -> void:
	var instance := spawn_scene.instantiate() as Node3D
	add_sibling(instance)
	instance.position = position
	opened.emit(self, instance)
	OneShotAudioPlayer.make_from(spawn_sound, get_parent()).volume_db = volume_db
	queue_free()
