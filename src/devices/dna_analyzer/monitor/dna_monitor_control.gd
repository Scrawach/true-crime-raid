class_name DNAMonitorControl
extends Control

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var process_container: VBoxContainer = %"Process Container"
@onready var result_label: Label = %"Result Label"

var data: DNAData
var progress_tween: Tween

func initialize(dna: DNAData) -> void:
	data = dna

func power_on() -> void:
	_kill_tween_if_needed()
	result_label.hide()
	process_container.show()
	progress_bar.show()
	progress_bar.value = 0
	animate_progress_bar()

func power_off() -> void:
	_kill_tween_if_needed()
	result_label.hide()
	progress_bar.hide()
	process_container.hide()

func finish_process() -> void:
	data.is_processed = true
	GameManager.dna_investigated.emit(data)
	progress_bar.hide()
	process_container.hide()
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
	result_label.text = data.get_content_string()
	result_label.show()
