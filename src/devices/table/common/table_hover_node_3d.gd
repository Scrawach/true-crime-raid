class_name TableHoverNode3D
extends Node3D

@export var valid_material: StandardMaterial3D
@export var invalid_material: StandardMaterial3D

@onready var hover_mesh: MeshInstance3D = %"Table Hover Mesh"
@onready var hover_path: MeshInstance3D = %"Table Hover Path"

func make_invalid() -> void:
	hover_mesh.material_override = invalid_material
	hover_path.material_override = invalid_material

func make_valid() -> void:
	hover_mesh.material_override = valid_material
	hover_path.material_override = valid_material

func enable() -> void:
	show()

func update(from: Vector3, to: Vector3) -> void:
	var distance := from.distance_to(to)
	hover_path.scale.y = distance
	hover_mesh.global_position = to

func disable() -> void:
	hide()
