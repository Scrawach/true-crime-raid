class_name InspectSceneAppear
extends Node

@export var canvas_layer: CanvasLayer
@export var main_control: Control
@export var background: InspectBackground

var tween: Tween
var deffered_callback: Callable

func smooth_show(callback: Callable = Callable()) -> Tween:
	_kill_tween_if_needed()
	canvas_layer.show()
	deffered_callback = callback
	tween = create_tween()
	tween.tween_subtween(background.smooth_show())
	tween.parallel().tween_property(background, "modulate:a", 1.0, 0.25)
	tween.parallel().tween_property(main_control, "modulate:a", 1.0, 0.25)
	tween.tween_callback(callback.call)
	return tween

func smooth_hide(callback: Callable = Callable()) -> Tween:
	_kill_tween_if_needed()
	deffered_callback = callback
	tween = create_tween()
	tween.tween_subtween(background.smooth_hide())
	tween.parallel().tween_property(background, "modulate:a", 1.0, 0.25)
	tween.parallel().tween_property(main_control, "modulate:a", 0.0, 0.25)
	tween.tween_callback(canvas_layer.hide)
	tween.tween_callback(callback.call)
	return tween

func _kill_tween_if_needed() -> void:
	if not tween:
		return
	
	var has_tweens := tween.custom_step(9999)
	
	if has_tweens and deffered_callback:
		deffered_callback.call()
		deffered_callback = Callable()
	
	tween.stop()
