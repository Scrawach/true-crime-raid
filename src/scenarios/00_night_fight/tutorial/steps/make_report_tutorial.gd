class_name MakeReportTutorial
extends QuestSubstageData


func start() -> void:
	pass

func stop() -> void:
	pass

static func create(description: String) -> MakeReportTutorial:
	var make_report := MakeReportTutorial.new()
	make_report.name = description
	return make_report
