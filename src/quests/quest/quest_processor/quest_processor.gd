class_name QuestProcessor extends Node

var current_objective:ObjectiveProcessor = null:set = current_objective_setter

func current_objective_setter(value):
	current_objective = value
	if current_objective != null:
		current_objective.activate()
		Quest.append_objective(current_objective)

func _ready() -> void:
	update_objective_task_links()

func on_task_triggered(task_code:String, steps:int):
	if current_objective != null:
		var t = current_objective.perform_task(task_code, steps)
		# Убеждаемся в том что одно из заданий было полностью решено
		if t!= null and t.is_completed:
			# Если выполнено достаточно заданий для перехода по ссылке проверяем наличие ссылки
			var link = current_objective.get_link()
			if link != null:
				# Если ссылка появилась в результате провала - проваливаем цель
				if t.fail:
					Quest.fail_objective(current_objective)
				# Если ссылка появилась в случае успеха - выполняем цель
				else:
					Quest.complete_objective(current_objective)
				if link != "end":
					current_objective = get_node(link)
				else:
					complete()

func on_task_triggered_back(task_code:String, steps:int):
	if current_objective != null:
		current_objective.roll_back_task(task_code, steps)

func activate(objective_name:String = ""):
	if current_objective == null:
		if objective_name != "":
			current_objective = get_node(objective_name)
		else:
			current_objective = get_child(0)
		Quest.task_triggered.connect(on_task_triggered)
		Quest.task_triggered_back.connect(on_task_triggered_back)
		Quest.quest_activated.emit(self)
	else:
		complete(true)
		activate(objective_name)
		

func complete(reseting:bool = false):
	Quest.task_triggered.disconnect(on_task_triggered)
	Quest.task_triggered_back.disconnect(on_task_triggered_back)
	if reseting:
		Quest.quest_reseted.emit(self)
	else:
		Quest.quest_completed.emit(self)
	current_objective = null


func update_objective_task_links():
	for obj_idx in range(get_child_count()):
		if obj_idx+1 < get_child_count():
			get_child(obj_idx).update_task_links(get_child(obj_idx+1).name)
		else:
			get_child(obj_idx).update_task_links("end")
