class_name ObjectiveProcessor extends Node

var tasks:Dictionary

static func create_objective(objective_name:String, objective_tasks:Array):
	var op = ObjectiveProcessor.new()
	op.name = objective_name
	for task in objective_tasks:
		op.tasks[task.code] = task
	return op

func activate():
	for task in tasks.values():
		task.reset()

func perform_task(task_code:String, steps:int) -> Task:
	if tasks.has(task_code):
		tasks[task_code].perform(steps)
		return tasks[task_code]
	else:
		return null	

func roll_back_task(task_code:String, steps:int):
	if tasks.has(task_code):
		tasks[task_code].rollback(steps)

func update_task_links(_next_objective_code:String):
	# Устанавливаем пропущенные значения ссылок для тасков выполнения
	for task in tasks.values():
		if task.link == "":
			task.link = _next_objective_code

func get_link():
	# Проверяем что выполнился ОДИН ИЗ провальных заданий
	for task in tasks.values():
		if task.fail and task.is_completed:
			return task.link
	# Проверяем что выполнились ВСЕ задания с одной ссылкой
	var links := {}
	# Группируем задачи по link (ВСЕ кроме дополнительных)
	for task in tasks.values():
		if task.link != "extra":
			if not links.has(task.link):
				links[task.link] = []
			links[task.link].append(task)
	# Проверяем группы на завершённость
	for link in links:
		var all_done := true
		for t in links[link]:
			if not t.is_completed:
				all_done = false
				break
		if all_done:
			return link
	return null
