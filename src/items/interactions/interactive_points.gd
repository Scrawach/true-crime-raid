class_name InteractivePoints
extends Node3D

signal clicked(point: InteractivePoint3D)

func _ready() -> void:
	for child in get_children():
		if child is InteractivePoint3D:
			child.clicked.connect(clicked.emit)

func enable() -> void:
	invoke_all(&"enable")

func disable() -> void:
	invoke_all(&"disable")

func invoke_all(method_name: StringName) -> void:
	for child in get_children():
		if child.has_method(method_name):
			child.call(method_name)
