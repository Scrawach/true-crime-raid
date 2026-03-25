class_name InspectBackground
extends PanelContainer


@export var min_blur: float = 0.0
@export var max_blur: float = 2.5
@export var duration: float = 0.25

@onready var blur_curtain: ColorRect = %"Blur Curtain"

var blur_material: ShaderMaterial
var tween: Tween

func _ready() -> void:
	blur_material = blur_curtain.material as ShaderMaterial

func smooth_show() -> Tween:
	_kill_tween_if_needed()
	tween = create_tween()
	tween.tween_method(blur_interpolate, 0.0, 1.0, duration)
	return tween

func smooth_hide() -> Tween:
	_kill_tween_if_needed()
	tween = create_tween()
	tween.tween_method(blur_interpolate, 1.0, 0.0, duration)
	return tween

func blur_interpolate(progress: float) -> void:
	var blur_amount := lerpf(min_blur, max_blur, progress)
	blur_material.set_shader_parameter("blur_amount", blur_amount)

func _kill_tween_if_needed() -> void:
	if tween:
		tween.custom_step(9999)
		tween.kill()
