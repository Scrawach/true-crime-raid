class_name PlayerInput
extends Node

@export var is_enabled: bool = true

func enable() -> void:
	is_enabled = true

func disable() -> void:
	is_enabled = false
