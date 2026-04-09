class_name ItemZoom
extends Node

@export var item_handler: ItemHandler


@export var min_distance: float = -0.4
@export var max_distance: float = 0.0

@export var scroll_strength: float = 0.05
@export var scroll_speed: float = 5

var zoom_relative: float

var desired_distance: float

func _ready() -> void:
	desired_distance = min_distance
	disable()

func clear() -> void:
	desired_distance = min_distance

func get_zoom_ratio() -> float:
	var ratio := (item_handler.position.y - min_distance) / (max_distance - min_distance)
	return ratio

func _process(delta: float) -> void:
	desired_distance = clampf(desired_distance + zoom_relative, min_distance, max_distance)
	var distance_step := desired_distance - item_handler.position.y
	item_handler.position.y += distance_step * delta * scroll_speed
	zoom_relative = 0

func enable() -> void:
	set_process_input(true)
	set_process(true)

func disable() -> void:
	set_process_input(false)
	set_process(false)

func is_small_enough() -> bool:
	return get_zoom_ratio() < 0.5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		if zoom_relative < 0:
			zoom_relative = 0
		zoom_relative += scroll_strength
	
	if event.is_action_pressed("scroll_down"):
		if zoom_relative > 0:
			zoom_relative = 0
		zoom_relative -= scroll_strength
