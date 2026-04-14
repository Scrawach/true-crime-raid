class_name WorkbenchAudio
extends Node

@export var interact: InteractWithWorkbench
@export var button: Button3D

@export var sample_player: AudioStreamPlayer
@export var press_player: AudioStreamPlayer

func _ready() -> void:
	interact.sample_taked.connect(_on_sampled)
	button.pressed.connect(_on_button_pressed)

func _on_sampled(_dna: DNAData) -> void:
	sample_player.play()

func _on_button_pressed() -> void:
	press_player.play()
