class_name SmoothAppearSprite3D
extends Node

@export var target: Sprite3D
@export var duration: float = 0.2
@export var target_scale: float = 2.0

var tween: Tween

func is_visible() -> bool:
	return target.visible

func smooth_show(callback: Callable = Callable()) -> void:
	_stop_if_needed()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(target, "modulate:a", 1.0, duration).from(0)
	tween.parallel().tween_property(target, "scale", Vector3.ONE, duration + duration / 2).from(Vector3.ONE * target_scale)
	tween.tween_callback(callback)
	target.show()

func smooth_hide(callback: Callable = Callable()) -> void:
	_stop_if_needed()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(target, "modulate:a", 0.0, duration)
	tween.parallel().tween_property(target, "scale", Vector3.ONE * target_scale, duration + duration / 2)
	tween.tween_callback(target.hide)
	tween.tween_callback(callback)

func _stop_if_needed() -> void:
	if tween:
		tween.custom_step(9999)
		tween.kill()
