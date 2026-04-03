class_name TimedPanel
extends Node

@export var panel: Control
@export var time: float

var timer: Timer
var tween: Tween

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timeout)

func timed_show() -> void:
	panel.show()
	timer.start(time)
	
	_stop_tween_if_needed()
	panel.pivot_offset_ratio = Vector2.ONE / 2
	tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.3).from(0.0)
	tween.parallel().tween_property(panel, "scale", Vector2.ONE, 0.3).from(Vector2.ONE * 1.25)

func _on_timeout() -> void:
	_stop_tween_if_needed()
	panel.pivot_offset_ratio = Vector2.ONE / 2
	tween = create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 0.3).from(1.0)
	tween.parallel().tween_property(panel, "scale", Vector2.ONE * 1.25, 0.3).from(Vector2.ONE)
	tween.tween_callback(panel.hide)

func _stop_tween_if_needed() -> void:
	if tween:
		tween.kill()
