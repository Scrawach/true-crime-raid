class_name Main
extends Node

@export var player: PlayerBody3D

@onready var startup_animation_player: AnimationPlayer = %"Startup AnimationPlayer"

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		startup()

func _ready() -> void:
	set_process_input(false)
	player.state_machine.switch_by_type(PlayerBlockedState)
	player.mouse.capture()
	
	await pause(1.0)
	set_process_input(true)

func startup() -> void:
	set_process_input(false)
	startup_animation_player.play("open")
	await pause(5.5)
	player.state_machine.switch_by_type(PlayerMovementState)

func pause(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
