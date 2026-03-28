class_name Computer
extends Node3D

signal report_completed(is_success: bool)

@onready var interact_with_computer: InteractWithComputer = %InteractWithComputer

func _ready() -> void:
	interact_with_computer.report_completed.connect(report_completed.emit)
