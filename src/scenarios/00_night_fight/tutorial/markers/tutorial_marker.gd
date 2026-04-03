class_name TutorialMarker
extends Sprite3D

@onready var label: Label = %Label

var follow_target: Node3D

func follow(target: Node3D, with_text: String = "") -> void:
	follow_target = target
	global_position = target.global_position + Vector3.UP / 2
	setup(with_text)
	show()

func setup(text: String) -> void:
	label.text = text

func clear() -> void:
	label.text = ""
	hide()
