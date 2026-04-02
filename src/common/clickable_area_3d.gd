class_name ClickableArea3D
extends Area3D

signal hovered()
signal clicked()
signal unhovered()

func hover() -> void:
	hovered.emit()
	
func click() -> void:
	clicked.emit()
	
func unhover() -> void:
	unhovered.emit()

func enable() -> void:
	set_active(true)

func disable() -> void:
	set_active(false)

func set_active(is_active: bool) -> void:
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = not is_active
