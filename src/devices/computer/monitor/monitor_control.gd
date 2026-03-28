class_name MonitorControl
extends Control

signal exited
signal report_completed(is_success: bool)

@export var mouse_cursor: ComputerMouseCursor

@onready var btn_exit: Button = %btn_exit
@onready var pa_report: APReport = %pa_report

func _ready() -> void:
	btn_exit.pressed.connect(exited.emit)
	pa_report.report_compiled_ok.connect(report_completed.emit.bind(true))

func power_on() -> void:
	pass

func power_off() -> void:
	pass
