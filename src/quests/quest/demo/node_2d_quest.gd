extends Node2D

@onready var quest_title_template: VBoxContainer = $CanvasLayer/MarginContainer/HBoxContainer/PanelContainer/VBoxContainer2/VBoxContainer
@onready var titles_holder: VBoxContainer = $CanvasLayer/MarginContainer/HBoxContainer/PanelContainer/VBoxContainer2/VBoxContainer2
@onready var buttons_holder: VBoxContainer = $CanvasLayer/MarginContainer/HBoxContainer/PanelContainer2/HBoxContainer
@onready var task_title_template: PanelContainer = $CanvasLayer/MarginContainer/HBoxContainer/PanelContainer/VBoxContainer2/VBoxContainer/VBoxContainer/PanelContainer
@onready var storage: Label = $CanvasLayer/MarginContainer/HBoxContainer/PanelContainer/VBoxContainer2/HBoxContainer/storage


func _ready() -> void:
	quest_title_template.hide()
	#storage.text = str(Bridge.storage.is_supported("local_storage"))
	#Progression.quests_loaded.connect(reload_card_holder)
	Quest.objective_appended.connect(append_objective_card)
	Quest.objective_completed.connect(delete_objective_card)
	Quest.objective_failed.connect(delete_objective_card)
	Quest.activate_quest("quest1")
	
	for node in get_parent().get_children():
		if node.has_method("_allready"):
			node._allready()


func trigger_task(task_code, steps):
	Quest.task_triggered.emit(task_code, steps)


func trigger_task_back(task_code, steps):
	Quest.task_triggered_back.emit(task_code, steps)


func append_objective_card(objective:ObjectiveProcessor):
	var d = quest_title_template.duplicate()
	titles_holder.add_child(d)
	d.tasks.get_child(0).queue_free()
	d.title.text = objective.name
	d.name = objective.name
	for task in objective.tasks.keys():
		var ttt = task_title_template.duplicate()
		d.tasks.add_child(ttt) 
		ttt.listen_task(objective.tasks[task])
		# Кнопка выполнения
		var b = Button.new()
		b.name = task
		b.pressed.connect(trigger_task.bind(b.name, 1))
		b.text = task
		buttons_holder.add_child(b)
		# Кнопка отката
		var bb = Button.new()
		bb.name = task
		bb.pressed.connect(trigger_task_back.bind(bb.name, 1))
		bb.text = task + " - rollback"
		buttons_holder.add_child(bb)
	d.show()


func delete_objective_card(objective:ObjectiveProcessor):
	titles_holder.get_node(str(objective.name)).queue_free()
	for button in buttons_holder.get_children():
		button.queue_free()


func reload_card_holder():
	for child in titles_holder.get_children():
		child.name = "deleted"
		child.queue_free()
	for btn in buttons_holder.get_children():
		btn.queue_free()


func _on_btn_save_pressed() -> void:
	pass
	#Progression.save_progress()


func _on_btn_load_pressed() -> void:
	pass
	#Progression.load_progress()


func _on_btn_delete_pressed() -> void:
	pass
	#Progression.delete_progress()
