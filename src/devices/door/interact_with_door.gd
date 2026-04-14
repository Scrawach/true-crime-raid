class_name InteractWithDoor
extends Node

@export var area: InteractionArea3D
@export var audio_stream: AudioStream
@export var volume_db: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area.interacted.connect(_on_interacted)

func _on_interacted(_player: PlayerBody3D) -> void:
	if animation_player.is_playing():
		return
	
	OneShotAudioPlayer.make_from(audio_stream, self).volume_db = volume_db
	animation_player.play("try_open")
