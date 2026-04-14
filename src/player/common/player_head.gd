class_name PlayerHead
extends Node3D

@export var player: PlayerBody3D

@export var bobbing_enabled := true
@export var bobbing_frequence := 3.6
@export var bobbing_amplitude := 0.025

var headbob_time: float
var initial_position: Vector3

func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	if not bobbing_enabled:
		return
	headbob_time += delta * player.velocity.length()
	_update_headbob_position(headbob_time)

func _update_headbob_position(progress: float) -> void:
	var target_position: Vector3 = initial_position
	target_position.x += cos(progress * bobbing_frequence / 2) * bobbing_amplitude
	target_position.y += sin(progress * bobbing_frequence) * bobbing_amplitude
	transform.origin = target_position
