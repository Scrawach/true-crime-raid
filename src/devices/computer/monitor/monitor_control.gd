class_name MonitorControl
extends Control

signal exited

@export var mouse_cursor: ComputerMouseCursor

@onready var btn_exit: Button = %btn_exit

func _ready() -> void:
	btn_exit.pressed.connect(exited.emit)

func power_on() -> void:
	pass

func power_off() -> void:
	pass
