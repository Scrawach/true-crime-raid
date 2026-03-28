class_name CheckItemTutorial
extends QuestSubstageData

var inspect: InspectItem

var items: Array[ItemData]
var checked: Array[ItemData]

func start() -> void:
	inspect.inspect_started.connect(_on_inspect_started)

func _on_inspect_started(target: BaseItem) -> void:
	var data := target.data
	
	if not data in items:
		return
	
	if data in checked:
		return
	
	checked.append(data)
	if checked.size() == items.size():
		finish()
	update()

func get_result_string() -> String:
	return "%s / %s" % [checked.size(), items.size()]

func stop() -> void:
	inspect.inspect_started.disconnect(_on_inspect_started)

static func create(description: String, inspector: InspectItem, targets: Array[ItemData]) -> CheckItemTutorial:
	var check := CheckItemTutorial.new()
	check.name = description
	check.inspect = inspector
	check.items = targets
	return check
