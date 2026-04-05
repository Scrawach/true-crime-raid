class_name Sticker
extends Area3D

@export var pin_node: Node3D

func pin() -> void:
	pin_node.show()

func unpin() -> void:
	pin_node.hide()
