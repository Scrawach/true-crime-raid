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
