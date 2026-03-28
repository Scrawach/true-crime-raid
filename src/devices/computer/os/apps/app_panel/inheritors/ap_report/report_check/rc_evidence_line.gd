class_name RCEvidenceLine
extends PanelContainer

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label


static var uid = "uid://ceifpmtir7twr"

static func create() -> EvidenceLine:
	var scene: PackedScene = ResourceLoader.load(uid)
	if scene == null:
		push_error("Failed to load scene by UID: " + uid)
		return null
	return scene.instantiate()
