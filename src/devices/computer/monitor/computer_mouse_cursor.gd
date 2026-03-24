class_name ComputerMouseCursor
extends TextureRect


func enable() -> void:
	set_physics_process(true)

func disable() -> void:
	set_physics_process(false)

func _process(_delta: float) -> void:
	position = get_viewport().get_mouse_position()-Vector2(20, 15)
