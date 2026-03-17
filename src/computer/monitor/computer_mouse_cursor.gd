class_name ComputerMouseCursor
extends Control

@onready var texture_rect: TextureRect = $TextureRect

func enable() -> void:
	set_physics_process(true)
	texture_rect.show()

func disable() -> void:
	set_physics_process(false)
	texture_rect.hide()

func _process(_delta: float) -> void:
	position = get_viewport().get_mouse_position()
