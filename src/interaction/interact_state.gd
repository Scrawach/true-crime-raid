class_name InteractState
extends Node

signal started()
signal stopped()

var player: PlayerBody3D
var is_interacted: bool

func start_interaction(body: PlayerBody3D) -> void:
	player = body
	is_interacted = true
	started.emit()

func stop_interaction() -> void:
	is_interacted = false
	stopped.emit()
	player = null
