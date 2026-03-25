class_name CameraZoom
extends Node

@export var camera: Camera3D
@export var scroll_strength: float = 0.05
@export var scroll_speed: float = 5

var zoom_relative: float

func enable() -> void:
	set_process_input(true)
	set_process(true)

func disable() -> void:
	set_process_input(false)
	set_process(false)

func get_zoom_ratio() -> float:
	return 1.0

func is_small_enough() -> bool:
	return get_zoom_ratio() < 0.5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		if zoom_relative > 0:
			zoom_relative = 0
		zoom_relative -= scroll_strength
	
	if event.is_action_pressed("scroll_down"):
		if zoom_relative < 0:
			zoom_relative = 0
		zoom_relative += scroll_strength
