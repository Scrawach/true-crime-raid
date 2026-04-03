class_name InteractState
extends Node

signal started()
signal stopped()

var player: PlayerBody3D
var is_interacted: bool

var in_interuptable: bool = true

func start_interaction(body: PlayerBody3D) -> void:
	player = body
	is_interacted = true
	started.emit()

func can_interupt() -> bool:
	return in_interuptable

func stop_interaction() -> void:
	is_interacted = false
	stopped.emit()
	player = null

func set_interuptable(new_value: bool) -> void:
	in_interuptable = new_value
