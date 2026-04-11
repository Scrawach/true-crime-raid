@tool
class_name DNAMonitor3D
extends MeshInstance3D

@export var resolution: Vector2i = Vector2i(512, 512):
	set(value):
		resolution = value
		_update_mesh_size()

@export var mesh_scaling: float = 1.0:
	set(value):
		mesh_scaling = value
		_update_mesh_size()

@export var sub_viewport_scaling: float = 1.0:
	set(value):
		sub_viewport_scaling = value
		_update_mesh_size()

@export var initial_control: PackedScene

@onready var monitor_sub_viewport: SubViewport = %"Monitor SubViewport"
@onready var background: ColorRect = %Background

var content: Control

func _update_mesh_size() -> void:
	if not is_node_ready():
		await ready
	
	var target_size := Vector2(resolution) / 1000
	if not mesh is QuadMesh:
		push_error("Monitor mesh should be QuadMesh!")
		return
	mesh.size = target_size * mesh_scaling
	monitor_sub_viewport.size = resolution * sub_viewport_scaling

func power_on() -> void:
	if not content:
		content = initial_control.instantiate() as Control
		background.add_child(content)

func power_off() -> void:
	pass
