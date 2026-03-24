@icon("res://addons/states/state-icon.svg")
class_name State
extends Node

var state_machine: StateMachine
var is_active: bool

func state_handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func state_process(_delta: float) -> void:
	pass
