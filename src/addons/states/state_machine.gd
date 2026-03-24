@icon("res://addons/states/state-machine-icon.svg")
class_name StateMachine
extends Node

signal state_entered(target: State)
signal state_exited(target: State)

@export var initial_state: State

var previous_state: State
var current_state: State
var states: Dictionary[GDScript, State]

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self
			states[child.get_script()] = child
	switch_to(initial_state)

func _unhandled_input(event: InputEvent) -> void:
	if not current_state:
		return
	
	current_state.state_handle_input(event)

func _physics_process(delta: float) -> void:
	if not current_state:
		return
	
	current_state.state_process(delta)

func switch_to(next_state: State) -> void:
	if current_state:
		previous_state = current_state
		current_state.exit()
		state_exited.emit(current_state)
	current_state = next_state
	current_state.enter()
	state_entered.emit(current_state)

func step_back() -> void:
	if previous_state != null:
		switch_to(previous_state)
	else:
		switch_to(initial_state)
