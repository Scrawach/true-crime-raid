class_name Monitor3D
extends MeshInstance3D

@onready var monitor_sub_viewport: SubViewport = %"Monitor SubViewport"
@onready var monitor_area_3d: Area3D = %"Monitor Area3D"
@onready var monitor_control: MonitorControl = %"Monitor Control"

@export var is_disabled: bool = true

var monitor_mesh_size: Vector2
var is_mouse_inside_monitor: bool
var previous_event_position_2d := Vector2()
var previous_event_time := -1.0

func _ready() -> void:
	if not mesh is QuadMesh:
		push_error("Monitor mesh should be QuadMesh!")
	else:
		monitor_mesh_size = mesh.size

func power_on() -> void:
	if is_disabled:
		monitor_area_3d.mouse_entered.connect(_on_mouse_entered)
		monitor_area_3d.mouse_exited.connect(_on_mouse_exited)
		monitor_area_3d.input_event.connect(_on_input_event)
	is_disabled = false

func power_off() -> void:
	if not is_disabled:
		monitor_area_3d.mouse_entered.disconnect(_on_mouse_entered)
		monitor_area_3d.mouse_exited.disconnect(_on_mouse_exited)
		monitor_area_3d.input_event.disconnect(_on_input_event)
	is_disabled = true

func _on_mouse_entered() -> void:
	is_mouse_inside_monitor = true

func _on_mouse_exited() -> void:
	is_mouse_inside_monitor = false

func _on_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var monitor_event := _translate_to_monitor_event(event, event_position)
	monitor_sub_viewport.push_input(monitor_event)

func _translate_to_monitor_event(event: InputEvent, event_position: Vector3) -> InputEvent:
	var event_position_3d := global_transform.affine_inverse() * event_position
	var monitor_position_2d := _get_position_on_monitor(event_position_3d)
	var now := Time.get_ticks_msec() / 1_000.0
	
	if event is InputEventMouse:
		event.position = monitor_position_2d
		event.global_position = monitor_position_2d
	
	if event is InputEventMouseMotion:
		event.relative = monitor_position_2d - previous_event_position_2d
		event.velocity = event.relative / (now - previous_event_time)
	
	previous_event_position_2d = monitor_position_2d
	previous_event_time = now
	return event

func _get_position_on_monitor(event_position_3d: Vector3) -> Vector2:
	if not is_mouse_inside_monitor:
		return previous_event_position_2d
	var event_position_2d = Vector2(event_position_3d.x, -event_position_3d.y)
	event_position_2d /= monitor_mesh_size
	event_position_2d += Vector2.ONE * 0.5
	event_position_2d *= Vector2(monitor_sub_viewport.size)
	return event_position_2d
