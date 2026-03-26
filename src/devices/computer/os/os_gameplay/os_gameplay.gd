class_name OSGameplay
extends Node

@export_group("Data")
@export var scenarios:Array[Scenario]
@export_group("GUI")
@export var ap_debug:APDebug
@export var ap_keywords:APKeywords
@export var ap_report:APReport


var current_scenario:Scenario
var keywords_pool:Dictionary[KeywordData, bool]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.keyword_found.connect(on_keyword_found)
	ap_report.report_compiled_ok.connect(on_report_compiled_ok)
	ap_debug.fill_scenarios_list(scenarios)
	ap_debug.start_scenario.connect(setup_scenario)

func setup_scenario(scenario:Scenario):
	if scenario == current_scenario:
		return
	#
	current_scenario = scenario
	for kw in current_scenario.extract_keywords():
		keywords_pool[kw] = false
	#
	ap_keywords.clear_containers()
	ap_keywords.fill_containers(keywords_pool)
	#
	ap_debug.fill_container(keywords_pool.keys())
	#
	ap_report.clear_data()
	ap_report.fill_data(current_scenario.felon, current_scenario.motive, current_scenario.cluster_to_kw(current_scenario.evidences))

func on_keyword_found(kw:KeywordData):
	if not kw in keywords_pool.keys():
		printerr(" to do - OSGameplay - on_keyword_found - kw not registrated")
		return
	keywords_pool[kw] = true
	ap_keywords.keyword_buttons[kw].show()

func on_report_compiled_ok():
	current_scenario = null
	ap_keywords.clear_containers()
	ap_report.clear_data()
	ap_debug.hide()
	ap_keywords.hide()
	ap_report.hide()
