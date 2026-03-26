class_name EvidenceLine
extends HBoxContainer

@onready var button: Button = $Button
@onready var label: Label = $Label

static var uid = "uid://bpgwverh8fyb4"

static func create() -> EvidenceLine:
	var scene: PackedScene = ResourceLoader.load(uid)
	if scene == null:
		push_error("Failed to load scene by UID: " + uid)
		return null
	return scene.instantiate()
