class_name TableHoverNode3D
extends Node3D

@export var valid_material: StandardMaterial3D
@export var invalid_material: StandardMaterial3D

@onready var hover_mesh: MeshInstance3D = %"Table Hover Mesh"
@onready var hover_path: MeshInstance3D = %"Table Hover Path"

@onready var area_3d: Area3D = %Area3D
@onready var collision_shape_3d: CollisionShape3D = %CollisionShape3D


var valid_position: bool = true

func _ready() -> void:
	area_3d.area_entered.connect(_on_area_entered)
	area_3d.area_exited.connect(_on_area_exited)

func _on_area_entered(_area: Area3D) -> void:
	valid_position = false

func _on_area_exited(_area: Area3D) -> void:
	valid_position = true

func is_valid_position() -> bool:
	return valid_position

func make_invalid() -> void:
	hover_mesh.material_override = invalid_material
	hover_path.material_override = invalid_material

func make_valid() -> void:
	hover_mesh.material_override = valid_material
	hover_path.material_override = valid_material

func enable() -> void:
	collision_shape_3d.disabled = false
	show()

func update(from: Vector3, to: Vector3) -> void:
	var distance := from.distance_to(to)
	hover_path.scale.y = distance
	hover_mesh.global_position = to

func disable() -> void:
	collision_shape_3d.disabled = true
	hide()
