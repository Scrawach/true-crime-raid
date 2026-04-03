class_name UVLamp
extends Node3D

signal changed(is_active: bool)

@onready var button_clickable_area_3d: ClickableArea3D = %"Button ClickableArea3D"
@onready var spot_light_3d: SpotLight3D = %SpotLight3D

@export var environment: Environment
@export var uv_label: Label3D

var is_working: bool = false

func _ready() -> void:
	button_clickable_area_3d.clicked.connect(_on_clicked)
	disable()

func enable() -> void:
	uv_label.show()
	button_clickable_area_3d.enable()

func disable() -> void:
	if is_working:
		power_off()
	uv_label.hide()
	button_clickable_area_3d.disable()

func _on_clicked() -> void:
	if is_working:
		power_off()
	else:
		power_on()

func power_on() -> void:
	environment.ambient_light_color = Color.BLACK
	set_active(true)

func power_off() -> void:
	environment.ambient_light_color = Color.WHITE
	set_active(false)

func set_active(is_active: bool) -> void:
	is_working = is_active
	spot_light_3d.visible = is_active
	changed.emit(is_active)
