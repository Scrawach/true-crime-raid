class_name TutorialRunner
extends Node

@export var player: PlayerBody3D
@export var startup_box: Box
@export var quest_container: QuestContainer
@export var target_document_data: Array[ItemData]
@export var target_items_data: Array[ItemData]

var tutorial: QuestData

func _ready() -> void:
	#tutorial = make_tutorial()
	#quest_container.initialize(tutorial)
	#tutorial.start()
	
	var quest := QuestData.create("Дело \"Ночная драка\"")
	print(quest.name)
	quest_container.initialize(quest)
	start_tutorial(quest)

func start_tutorial(quest: QuestData) -> void:
	var open_box := OpenBoxTutorial.create("Откройте коробку с первым делом", startup_box)
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
	
	var find_dna := FindDNACountTutorial.create("Изучите пробирке в анализаторе", 6)
	find_dna.is_active = false
	quest.add_stage(find_dna)
	
	var report := MakeReportTutorial.create("Составьте отчёт по делу")
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

func _on_tutorial_ended(stage: QuestSubstageData) -> void:
	print("GAME OVER!")
	pass
