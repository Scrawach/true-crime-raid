class_name StickerHolder
extends Node3D

@export var show_position: Node3D
@export var hide_position: Node3D
@export var smooth_duration: float = 0.4

var tween: Tween

func smooth_show(callback: Callable = Callable()) -> void:
	show()
	_stop_tween_if_needed()
	tween = create_tween()
	tween.tween_property(self, "global_position", show_position.global_position, smooth_duration)
	tween.tween_callback(callback)

func smooth_hide(callback: Callable = Callable()) -> void:
	_stop_tween_if_needed()
	tween = create_tween()
	tween.tween_property(self, "global_position", hide_position.global_position, smooth_duration / 2)
	tween.tween_callback(hide)
	tween.tween_callback(callback)

func _stop_tween_if_needed() -> void:
	if tween:
		tween.stop()
