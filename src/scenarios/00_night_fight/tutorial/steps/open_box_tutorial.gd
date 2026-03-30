class_name OpenBoxTutorial
extends QuestSubstageData

var box: Box
var marker: TutorialMarker

func start() -> void:
	box.opened.connect(_on_box_opened)
	marker.follow(box, "Первое дело")

func _on_box_opened(_box: Box, _spawned_object: Node3D) -> void:
	finish()
	marker.hide()

static func create(description: String, target: Box, tutorial_marker: TutorialMarker) -> OpenBoxTutorial:
	var data := OpenBoxTutorial.new()
	data.name = description
	data.box = target
	data.marker = tutorial_marker
	return data
