class_name InspectorItemHandler
extends Node3D

@export var camera_zoom: CameraZoom
@export var min_camera_zoom_strength: float = 0.55
@export var max_camera_zoom_strength: float = 1.0

@export var sensitivity: float = 0.5
@export var rotation_speed: float = 1.5
@export var rotation_damper: float = 2.0

var dragging := false
var yaw := 0.0
var pitch := 0.0

var pre_capture_mouse_position: Vector2
var rotation_step: Vector2

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if dragging:
			pre_capture_mouse_position = get_viewport().get_mouse_position()
			rotation_step = Vector2.ZERO
			#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#else:
			#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			#_restore_mouse_position.call_deferred()
	
	if event is InputEventMouseMotion and dragging:
		var strength := lerpf(min_camera_zoom_strength, max_camera_zoom_strength, camera_zoom.get_zoom_ratio())
		rotation_step = event.relative * sensitivity * strength

func stop_rotation() -> void:
	rotation_step = Vector2.ZERO

func _restore_mouse_position() -> void:
	Input.warp_mouse(pre_capture_mouse_position)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	rotate(Vector3.UP, rotation_step.x * delta)
	rotate(Vector3.RIGHT, rotation_step.y * delta)
	var step := rotation_step.length() * delta
	rotation_step = rotation_step.move_toward(Vector2.ZERO, step)
