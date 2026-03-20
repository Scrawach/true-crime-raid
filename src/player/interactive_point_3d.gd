class_name InteractivePoint3D
extends Node3D

signal mouse_entered()
signal mouse_exited()
signal clicked(point: InteractivePoint3D)

@export var is_disabled: bool

@onready var smooth_appear_sprite_3d: SmoothAppearSprite3D = $Tooltip/SmoothAppearSprite3D
@onready var visible_point_on_camera: VisiblePointOnCamera = $VisiblePointOnCamera
@onready var clickable_area_3d: ClickableArea3D = $ClickableArea3D
@onready var collision_shape_3d: CollisionShape3D = %CollisionShape3D

func _ready() -> void:
	visible_point_on_camera.screen_entered.connect(_on_screen_entered)
	visible_point_on_camera.screen_exited.connect(_on_screen_exited)
	clickable_area_3d.hovered.connect(mouse_entered.emit)
	clickable_area_3d.unhovered.connect(mouse_exited.emit)
	
	if is_disabled:
		disable()
	else:
		enable()

func _on_screen_entered() -> void:
	smooth_appear_sprite_3d.smooth_show()
	clickable_area_3d.clicked.connect(_on_clicked)

func _on_screen_exited() -> void:
	smooth_appear_sprite_3d.smooth_hide()
	clickable_area_3d.clicked.disconnect(_on_clicked)

func is_active() -> bool:
	return visible_point_on_camera.is_visible_on_screen

func disable() -> void:
	visible_point_on_camera.disable()
	if smooth_appear_sprite_3d.is_visible():
		smooth_appear_sprite_3d.smooth_hide()
	collision_shape_3d.disabled = true

func enable() -> void:
	visible_point_on_camera.enable()
	collision_shape_3d.disabled = false

func _on_clicked() -> void:
	clicked.emit(self)
