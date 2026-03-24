class_name BaseItem
extends RigidBody3D

@export var data: ItemData
@export var points: InteractivePoints

@onready var interact_tooltip_3d: InteractTooltip3D = $InteractTooltip3D

func grab() -> void:
	freeze = true
	interact_tooltip_3d.disable()

func ungrab() -> void:
	freeze = false
	interact_tooltip_3d.enable()

func get_interactive_points() -> InteractivePoints:
	return points

func get_description() -> String:
	return data.description
