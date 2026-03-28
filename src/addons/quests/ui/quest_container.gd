class_name QuestContainer
extends PanelContainer

@export var substage_panel: PackedScene

@onready var quest_header: Label = %"Quest Header"
@onready var substages_container: VBoxContainer = %"Substages Container"

var quest_panels: Dictionary[QuestSubstageData, QuestSubstagePanel]

func initialize(data: QuestData) -> void:
	show()
	quest_header.text = data.name
	initialize_stages(data.substages)
	data.stage_added.connect(_on_stage_added)
	data.stage_removed.connect(_on_stage_removed)

func _on_stage_added(stage: QuestSubstageData) -> void:
	quest_panels[stage] = make_substage_panel(stage)
	_on_stage_updated(stage)
	stage.updated.connect(_on_stage_updated)

func _on_stage_removed(stage: QuestSubstageData) -> void:
	if not quest_panels.has(stage):
		return
	var panel := quest_panels[stage]
	panel.remove()

func initialize_stages(stages: Array[QuestSubstageData]) -> void:
	for stage in stages:
		_on_stage_added(stage)

func make_substage_panel(stage: QuestSubstageData) -> QuestSubstagePanel:
	var instance := substage_panel.instantiate() as QuestSubstagePanel
	substages_container.add_child(instance)
	instance.initialize(stage)
	return instance

func _on_stage_updated(stage: QuestSubstageData) -> void:
	if not quest_panels.has(stage):
		return
	var panel := quest_panels[stage]
	if stage.is_active:
		panel.show()
	else:
		panel.hide()
