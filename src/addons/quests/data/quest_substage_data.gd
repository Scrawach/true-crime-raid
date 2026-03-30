class_name QuestSubstageData
extends Resource

signal updated(stage: QuestSubstageData)
signal finished(stage: QuestSubstageData)

@export var name: String

var is_active: bool = true
var is_finished: bool

func get_result_string() -> String:
	return ""

func start() -> void:
	pass

func update() -> void:
	if not is_active:
		activate()
	updated.emit(self)

func activate() -> void:
	is_active = true

func stop() -> void:
	pass

func finish() -> void:
	update()
	is_finished = true
	finished.emit(self)
