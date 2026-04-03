class_name TakeDNATubesCountTutorial
extends QuestSubstageData

@export var target_count: int

var workspaces: Array[Workbench]
var marker: TutorialMarker

var reached_count: int = 0

func start() -> void:
	for workspace in workspaces:
		workspace.sample_taked.connect(_on_sample_taked)
		workspace.interaction_started.connect(_on_interaction_started)
		workspace.interaction_stopped.connect(_on_interaction_stopped)

func _on_interaction_started() -> void:
	marker.clear()

func _on_interaction_stopped() -> void:
	marker.follow(workspaces[0], "Рабочее место")

func _on_sample_taked(_data: DNAData) -> void:
	reached_count += 1
	
	update()
	if reached_count >= target_count:
		finish()

func activate() -> void:
	super.activate()
	marker.follow(workspaces[0], "Рабочее место")

func finish() -> void:
	marker.hide()
	super.finish()

func stop() -> void:
	for workspace in workspaces:
		workspace.sample_taked.disconnect(_on_sample_taked)
		workspace.interaction_started.disconnect(_on_interaction_started)
		workspace.interaction_stopped.disconnect(_on_interaction_stopped)

func get_result_string() -> String:
	return "%s / %s" % [ reached_count, target_count]

static func create(description: String, target: int, workbenches: Array[Workbench], tutorial_marker: TutorialMarker) -> TakeDNATubesCountTutorial:
	var data := TakeDNATubesCountTutorial.new()
	data.name = description
	data.target_count = target
	data.workspaces = workbenches
	data.marker = tutorial_marker
	return data
