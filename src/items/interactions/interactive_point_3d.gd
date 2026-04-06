class_name InteractivePoint3D
extends Node3D

signal mouse_entered()
signal mouse_exited()
signal clicked(point: InteractivePoint3D)

@export var is_disabled: bool
@export var is_small: bool
@export var visible_distance: float = 0.4

@onready var smooth_appear_sprite_3d: SmoothAppearSprite3D = $Tooltip/SmoothAppearSprite3D
@onready var tooltip: Sprite3D = $Tooltip

@onready var visible_point_on_camera: VisiblePointOnCameraWithSize = $VisiblePointOnCameraWithSize
@onready var clickable_area_3d: ClickableArea3D = $ClickableArea3D
@onready var collision_shape_3d: CollisionShape3D = %CollisionShape3D

var hover_tween: Tween

func _ready() -> void:
	visible_point_on_camera.is_small_point = is_small
	visible_point_on_camera.visible_distance = visible_distance
	if is_small:
		clickable_area_3d.collision_layer = 32
	else:
		clickable_area_3d.collision_layer = 16
	
	if is_disabled:
		disable()
	else:
		enable()
	
	visible_point_on_camera.screen_entered.connect(_on_screen_entered)
	visible_point_on_camera.screen_exited.connect(_on_screen_exited)
	clickable_area_3d.hovered.connect(_on_mouse_entered)
	clickable_area_3d.unhovered.connect(_on_mouse_exited)
	clickable_area_3d.clicked.connect(_on_clicked)

func _on_screen_entered() -> void:
	smooth_appear_sprite_3d.smooth_show()
	clickable_area_3d.enable()

func _on_screen_exited() -> void:
	smooth_appear_sprite_3d.smooth_hide()
	clickable_area_3d.disable()

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

func _on_mouse_entered() -> void:
	mouse_entered.emit()
	_kill_hover_if_need()
	hover_tween = create_tween()
	hover_tween.tween_property(tooltip, "pixel_size", 0.0015, 0.15)

func _on_mouse_exited() -> void:
	mouse_exited.emit()
	_kill_hover_if_need()
	hover_tween = create_tween()
	hover_tween.tween_property(tooltip, "pixel_size", 0.001, 0.15)

func _kill_hover_if_need() -> void:
	if hover_tween:
		hover_tween.custom_step(9999)
		hover_tween.kill()
