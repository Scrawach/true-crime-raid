class_name OpenBoxTutorial
extends QuestSubstageData

var box: Box

func start() -> void:
	box.opened.connect(_on_box_opened)

func _on_box_opened(box: Box, spawned_object: Node3D) -> void:
	finish()

static func create(description: String, target: Box) -> OpenBoxTutorial:
	var data := OpenBoxTutorial.new()
	data.name = description
	data.box = target
	return data
