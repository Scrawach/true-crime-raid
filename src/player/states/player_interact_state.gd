class_name PlayerInteractState
extends PlayerState

@export var interactor: PlayerInteractor
@export var mouse_capture: MouseCapture

var current_interaction: InteractState

func state_handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") or event.is_action("inspect"):
		if current_interaction and current_interaction.can_interupt():
			current_interaction.stop_interaction()

func enter() -> void:
	var is_success := interactor.try_interact()
	
	if is_success and interactor.interaction.has_interact_state():
		var state := interactor.interaction.interact_state
		current_interaction = state
		current_interaction.start_interaction(player)
		current_interaction.stopped.connect(_on_interaction_done)
	else:
		state_machine.step_back()

func exit() -> void:
	if current_interaction:
		current_interaction.stopped.disconnect(_on_interaction_done)
		current_interaction = null

func _on_interaction_done() -> void:
	state_machine.step_back()
