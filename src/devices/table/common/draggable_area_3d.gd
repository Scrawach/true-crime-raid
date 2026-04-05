class_name DraggableArea3D
extends Area3D

signal drag_started()
signal dragged()
signal drag_ended()
signal dropped()

signal hovered()
signal unhovered()
signal clicked()

func hover() -> void:
	hovered.emit()
