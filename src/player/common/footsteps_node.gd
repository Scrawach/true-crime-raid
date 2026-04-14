class_name FootstepsNode
extends Node

@export var frequence: float = 20.0

@export var movement_state: PlayerMovementState

@export var stream: AudioStream
@export var volume_db: float

var is_triggered: bool

func _physics_process(delta: float) -> void:
	if not movement_state.is_active():
		return
	
	var input := movement_state.get_movement_input().length()
	
	if input > 0.5:
		process_footstep()

func process_footstep() -> void:
	var result := sin(get_seconds() * frequence)
	if result >= 0.5 and not is_triggered:
		is_triggered = true
		var footstep := OneShotAudioPlayer.make_from(stream, self)
		footstep.volume_db = volume_db
	elif result <= 0.5 and is_triggered:
		is_triggered = false

func get_seconds() -> float:
	return Time.get_ticks_msec() / 1_000.00
