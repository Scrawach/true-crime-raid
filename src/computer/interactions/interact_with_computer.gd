class_name InteractWithComputer
extends Node

@export var monitor_3d: Monitor3D
@export var computer_camera: Camera3D
@export var interaction: InteractionArea3D
@export var computer_canvas: CanvasLayer

var interactor: PlayerBody3D
var is_interacted: bool = false

func _ready() -> void:
	interaction.interacted.connect(_on_interacted)
	set_process_input(false)

func _on_interacted(player: PlayerBody3D) -> void:
	interactor = player
	is_interacted = true
	start_interaction(interactor)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		stop_interaction(interactor)
		get_viewport().set_input_as_handled()

func start_interaction(target: PlayerBody3D) -> void:
	computer_camera.make_current()
	interaction.disable()
	monitor_3d.power_on()
	
	set_process_input(true)
	target.input.disable()
	target.input.mouse_capture.uncapture()
	target.player_hud.hide_aim_pointer()
	computer_canvas.show()

func stop_interaction(target: PlayerBody3D) -> void:
	target.main_camera.make_current()
	interaction.enable()
	monitor_3d.power_off()
	
	set_process_input(false)
	target.input.enable()
	target.input.mouse_capture.capture()
	target.player_hud.show_aim_pointer()
	computer_canvas.hide()
	
