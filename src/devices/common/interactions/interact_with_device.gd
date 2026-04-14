class_name InteractWithDevice
extends InteractState

signal camera_move_started()
signal camera_move_stopped()

@export var interaction_camera: Camera3D
@export var interaction_area: InteractionArea3D

var camera_moving_tween: Tween
var main_camera_local_transform: Transform3D

func exit_from_device():
	stop_interaction()
	get_viewport().set_input_as_handled()

func start_interaction(target: PlayerBody3D) -> void:
	_kill_camera_moving_if_needed()
	
	target.play_woosh()
	super.start_interaction(target)
	main_camera_local_transform = target.main_camera.transform
	smooth_camera_moving(target.main_camera, interaction_camera.global_transform, camera_move_stopped.emit)
	interaction_area.disable()
	
	target.player_hud.hide_aim_pointer()

func stop_interaction() -> void:
	_kill_camera_moving_if_needed()
	
	reset_main_camera(player.main_camera)
	interaction_area.enable()
	player.play_woosh()
	player.player_hud.show_aim_pointer()
	super.stop_interaction()

func smooth_camera_moving(target: Camera3D, target_transform: Transform3D, callback: Callable) -> void:
	_kill_camera_moving_if_needed()
	camera_move_started.emit()
	camera_moving_tween = create_tween()
	camera_moving_tween.set_trans(Tween.TRANS_EXPO)
	camera_moving_tween.tween_property(target, "global_transform", target_transform, 0.3)
	camera_moving_tween.tween_callback(callback)

func reset_main_camera(target: Camera3D) -> void:
	_kill_camera_moving_if_needed()
	camera_moving_tween = create_tween()
	camera_moving_tween.tween_property(target, "transform", main_camera_local_transform, 0.3)


func _kill_camera_moving_if_needed() -> void:
	if camera_moving_tween:
		camera_moving_tween.custom_step(9999)
		camera_moving_tween.kill()
