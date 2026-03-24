class_name InteractWithDevice
extends Node

@export var interaction_camera: Camera3D
@export var interaction_area: InteractionArea3D

var interactor: PlayerBody3D
var is_interacted: bool = false

var camera_moving_tween: Tween
var main_camera_local_transform: Transform3D

func _ready() -> void:
	interaction_area.interacted.connect(_on_interacted)
	set_process_input(false)

func _on_interacted(player: PlayerBody3D) -> void:
	interactor = player
	is_interacted = true
	start_interaction(interactor)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		exit_from_device()

func exit_from_device():
	stop_interaction(interactor)
	get_viewport().set_input_as_handled()

func start_interaction(target: PlayerBody3D) -> void:
	main_camera_local_transform = target.main_camera.transform
	smooth_camera_moving(target.main_camera, interaction_camera.global_transform)
	interaction_area.disable()
	set_process_input(true)
	
	target.input.disable()
	target.input.mouse_capture.hide_cursor()
	target.player_hud.hide_aim_pointer()

func stop_interaction(target: PlayerBody3D) -> void:
	reset_main_camera(target.main_camera)
	interaction_area.enable()
	set_process_input(false)
	
	target.input.enable()
	target.input.mouse_capture.capture()
	target.player_hud.show_aim_pointer()

func smooth_camera_moving(target: Camera3D, target_transform: Transform3D) -> void:
	_kill_camera_moving_if_needed()
	camera_moving_tween = create_tween()
	camera_moving_tween.set_trans(Tween.TRANS_EXPO)
	camera_moving_tween.tween_property(target, "global_transform", target_transform, 0.3)

func reset_main_camera(target: Camera3D) -> void:
	_kill_camera_moving_if_needed()
	camera_moving_tween = create_tween()
	camera_moving_tween.tween_property(target, "transform", main_camera_local_transform, 0.3)


func _kill_camera_moving_if_needed() -> void:
	if camera_moving_tween:
		camera_moving_tween.custom_step(9999)
		camera_moving_tween.kill()
