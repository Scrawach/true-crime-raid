class_name UVLamp
extends Node3D

@onready var button_clickable_area_3d: ClickableArea3D = %"Button ClickableArea3D"
@onready var spot_light_3d: SpotLight3D = %SpotLight3D


func _ready() -> void:
	button_clickable_area_3d.clicked.connect(_on_clicked)
	disable()

func enable() -> void:
	button_clickable_area_3d.enable()

func disable() -> void:
	if spot_light_3d.visible:
		spot_light_3d.hide()
	
	button_clickable_area_3d.disable()

func _on_clicked() -> void:
	spot_light_3d.visible = not spot_light_3d.visible
	print("HELLO, WORLD!")
