class_name BaseItem
extends RigidBody3D

@onready var interact_tooltip_3d: InteractTooltip3D = $InteractTooltip3D

func grab() -> void:
	freeze = true
	interact_tooltip_3d.disable()

func ungrab() -> void:
	freeze = false
	interact_tooltip_3d.enable()
