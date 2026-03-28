class_name QuestData
extends Resource

signal stage_added(stage: QuestSubstageData)
signal stage_removed(stage: QuestSubstageData)

signal stage_updated(stage: QuestSubstageData)
signal stage_finished(stage: QuestSubstageData)

@export var name: String
@export var substages: Array[QuestSubstageData]

func start() -> void:
	for stage in substages:
		add_stage(stage)

func stop() -> void:
	for stage in substages:
		stage.stop()
		stage.updated.disconnect(stage_updated.emit)
		stage.finished.disconnect(stage_finished.emit)

func add_stage(stage: QuestSubstageData) -> void:
	stage.start()
	stage.updated.connect(stage_updated.emit)
	stage.finished.connect(stage_finished.emit)
	stage_added.emit(stage)

func remove_stage(stage: QuestSubstageData) -> void:
	stage.stop()
	substages.erase(stage)
	stage_removed.emit(stage)

static func create(name: String, stages: Array[QuestSubstageData] = []) -> QuestData:
	var data := QuestData.new()
	data.name = name
	data.substages = stages
	return data
