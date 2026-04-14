class_name Button3D
extends Node3D

signal pressed()

@onready var button_clickable_area_3d: ClickableArea3D = %"Button ClickableArea3D"
@onready var button_animation_player: AnimationPlayer = %"Button AnimationPlayer"

var is_pressed: bool

func _ready() -> void:
	button_clickable_area_3d.clicked.connect(_on_clicked)

func _on_clicked() -> void:
	is_pressed = not is_pressed
	
	if is_pressed:
		button_animation_player.play("press")
	else:
		button_animation_player.play_backwards("press")
	
	pressed.emit()
