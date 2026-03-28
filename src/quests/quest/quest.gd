extends Node

signal task_triggered(code:String, steps:int)
signal task_triggered_back(code:String, steps:int)
signal objective_appended(objective:ObjectiveProcessor)
signal objective_completed(objective:ObjectiveProcessor)
signal objective_failed(objective:ObjectiveProcessor)
signal quest_activated(quest:QuestProcessor)
signal quest_completed(quest:QuestProcessor)
signal quest_reseted(quest:QuestProcessor)

var activated_objectives = []

func _ready() -> void:
	for qp in create_quest_processors("res://quests/quest/assets/Quests.csv"):
		add_child(qp)


func create_quest_processors(csv_path_quests_table:String)  -> Array[QuestProcessor]:
	# Создаем словарик quest_name:[objective_name:[tasks]]
	var t_dict = {}
	var current_quest_name = ""
	# Построчно считываем файл
	if csv_path_quests_table == null:
		printerr("to do - Global.refrences.csv_path_quests_table = null")
		return []
	else:
		var lines = CSVReader.read_all(csv_path_quests_table, 1)
		for line in lines:
			if line[0] == "quest_name":
				current_quest_name = line[1]
				t_dict[current_quest_name] = {}
			if current_quest_name != "":
				var t = Task.create_task(line)
				if t != null:
					if t.objective not in t_dict[current_quest_name].keys():
						t_dict[current_quest_name][t.objective] = []
					t_dict[current_quest_name][t.objective].append(t)
		# На основе словаря генерируем QuestProcessors
		var result:Array[QuestProcessor] = []
		for quest_name in t_dict.keys():
			var q = QuestProcessor.new()
			q.name = quest_name
			for objective_name in t_dict[quest_name].keys():
				q.add_child(ObjectiveProcessor.create_objective(objective_name, t_dict[quest_name][objective_name]))
			result.append(q)
		return result


func activate_quest(quest_name:String, objective_name:String = ""):
	if has_node(quest_name):
		get_node(quest_name).activate(objective_name)

#region Objectives
func append_objective(objective:ObjectiveProcessor):
	if objective not in activated_objectives:
		activated_objectives.append(objective)
		objective_appended.emit(objective)

func complete_objective(objective:ObjectiveProcessor):
	if objective in activated_objectives:
		activated_objectives.erase(objective)
		objective_completed.emit(objective)

func fail_objective(objective:ObjectiveProcessor):
	if objective in activated_objectives:
		activated_objectives.erase(objective)
		objective_failed.emit(objective)
#endregion

#region DataSaving
func serialize():
	var data = {}
	for obj in activated_objectives:
		data[obj.get_parent().name] = obj.name
	return str(data).replace('&"', '"')

func deserialize(data):
	activated_objectives = []
	for quest_name in data.keys():
		activate_quest(quest_name, data[quest_name])
#endregion 
