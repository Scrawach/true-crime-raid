@icon("res://addons/states/state-icon.svg")
class_name State
extends Node

var state_machine: StateMachine

func is_active() -> bool:
	return state_machine and state_machine.current_state == self

func state_handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func state_process(_delta: float) -> void:
	pass
