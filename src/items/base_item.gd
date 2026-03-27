class_name BaseItem
extends RigidBody3D

@export var data: ItemData
@export var points: InteractivePoints

@onready var interact_tooltip_3d: InteractTooltip3D = $InteractTooltip3D

var total_dna_points: int

func _ready() -> void:
	total_dna_points = get_dna_interactive_points().size()

func grab() -> void:
	if freeze:
		return
	
	freeze = true
	interact_tooltip_3d.disable()

func ungrab() -> void:
	if not freeze:
		return
	
	freeze = false
	interact_tooltip_3d.enable()

func get_interactive_points() -> InteractivePoints:
	return points

func get_dna_interactive_points() -> Array[DNAInteractivePoint3D]:
	var dna_points: Array[DNAInteractivePoint3D]
	for child in points.get_children():
		if child is DNAInteractivePoint3D:
			dna_points.append(child)
	return dna_points

func get_description() -> String:
	return data.description
