class_name DNAMonitorControl
extends Control

@onready var progress_bar: ProgressBar = %ProgressBar

@onready var match_result: VBoxContainer = %"Match Result"
@onready var name_label: Label = %"Name Label"
@onready var result_label: Label = %"Result Label"
@onready var type_label: Label = %"Type Label"

@onready var progress_container: PanelContainer = %"Progress Container"
@onready var no_match_result: VBoxContainer = %"NoMatch Result"

var data: DNAData
var progress_tween: Tween

func initialize(dna: DNAData) -> void:
	data = dna

func power_on() -> void:
	_kill_tween_if_needed()
	match_result.hide()
	no_match_result.hide()
	progress_container.show()
	progress_bar.value = 0
	animate_progress_bar()

func power_off() -> void:
	_kill_tween_if_needed()
	progress_container.hide()

func finish_process() -> void:
	data.is_processed = true
	GameManager.dna_investigated.emit(data)
	progress_container.hide()
	show_result_label()

func animate_progress_bar(callback: Callable = Callable()) -> void:
	progress_tween = create_tween()
	progress_tween.tween_interval(0.2)
	progress_tween.tween_property(progress_bar, "value", 1.0, 1.0).from(0)
	progress_tween.tween_interval(0.2)
	progress_tween.tween_callback(callback)
	progress_tween.tween_callback(finish_process)

func _kill_tween_if_needed() -> void:
	if progress_tween:
		progress_tween.kill()

func show_result_label() -> void:
	name_label.text = data.database_name
	result_label.text = "%.2f" % data.overlap_percentage
	type_label.text = data.match_type
	
	if data.database_name.is_empty():
		no_match_result.show()
	else:
		match_result.show()
