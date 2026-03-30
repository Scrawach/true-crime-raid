class_name MakeReportTutorial
extends QuestSubstageData

var computer: Computer
var marker: TutorialMarker

func start() -> void:
	computer.report_completed.connect(_on_report_completed)

func activate() -> void:
	super.activate()
	marker.follow(computer, "Компьютер")

func finish() -> void:
	marker.hide()
	super.finish()

func _on_report_completed(is_success: bool) -> void:
	if is_success:
		finish()

func stop() -> void:
	computer.report_completed.disconnect(_on_report_completed)

static func create(description: String, device: Computer, tutorial_marker: TutorialMarker) -> MakeReportTutorial:
	var make_report := MakeReportTutorial.new()
	make_report.name = description
	make_report.computer = device
	make_report.marker = tutorial_marker
	return make_report
