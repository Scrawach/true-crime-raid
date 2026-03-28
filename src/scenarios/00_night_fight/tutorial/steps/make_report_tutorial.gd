class_name MakeReportTutorial
extends QuestSubstageData

var computer: Computer

func start() -> void:
	computer.report_completed.connect(_on_report_completed)

func _on_report_completed(is_success: bool) -> void:
	if is_success:
		finish()

func stop() -> void:
	computer.report_completed.disconnect(_on_report_completed)

static func create(description: String, device: Computer) -> MakeReportTutorial:
	var make_report := MakeReportTutorial.new()
	make_report.name = description
	make_report.computer = device
	return make_report
