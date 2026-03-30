class_name TutorialRunner
extends Node

@export var player: PlayerBody3D
@export var computer: Computer
@export var dna_analyzer: Node3D
@export var startup_box: Box

@export var marker: TutorialMarker
@export var quest_container: QuestContainer
@export var target_document_data: Array[ItemData]
@export var target_items_data: Array[ItemData]

var tutorial: QuestData

func _ready() -> void:
	tutorial = QuestData.create("Дело \"Ночная драка\"")
	quest_container.initialize(tutorial)
	start_tutorial(tutorial)

func start_tutorial(quest: QuestData) -> void:
	var open_box := OpenBoxTutorial.create("Откройте коробку с первым делом", startup_box, marker)
	quest.add_stage(open_box)
	await open_box.finished
	var check_documents := CheckItemTutorial.create("Осмотрите документы", player.inspect_item, target_document_data)
	var check_items := CheckItemTutorial.create("Осмотрите улики", player.inspect_item, target_items_data)
	
	quest.add_stage(check_documents)
	quest.add_stage(check_items)
	
	var awaiter := AwaitAnyOf.new([check_documents.updated, check_items.updated])
	await awaiter.finished
	quest.remove_stage(open_box)
	
	var find_keywords := FindKeywordCountTutorial.create("Соберите ключевые слова", 9)
	quest.add_stage(find_keywords)
	
	var find_dna := FindDNACountTutorial.create("Изучите пробирке в анализаторе", 6, dna_analyzer, marker)
	find_dna.is_active = false
	quest.add_stage(find_dna)
	
	var report := MakeReportTutorial.create("Составьте отчёт по делу", computer, marker)
	report.is_active = false
	quest.add_stage(report)
	report.finished.connect(_on_tutorial_ended)
	
	var all_awaiter := AwaitAllOf.new([check_documents.finished, check_items.finished, find_keywords.finished])
	await all_awaiter.finished
	quest.remove_stage(find_keywords)
	quest.remove_stage(check_documents)
	quest.remove_stage(check_items)
	find_dna.update()
	
	if not find_dna.is_finished:
		await find_dna.finished
	
	quest.remove_stage(find_dna)
	report.update()
	await report.finished
	_on_tutorial_ended(report)
	quest.finish()

func _on_tutorial_ended(stage: QuestSubstageData) -> void:
	tutorial.finish()
