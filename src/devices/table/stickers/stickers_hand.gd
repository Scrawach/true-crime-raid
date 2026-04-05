class_name StickerHand
extends Node3D

@export var show_position: Node3D
@export var hide_position: Node3D
@export var smooth_duration: float = 0.4
@export var sticker_width: float = 0.25

var tween: Tween

func _ready() -> void:
	update_sticker_positions()

func smooth_show(callback: Callable = Callable()) -> void:
	show()
	_stop_tween_if_needed()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "global_position", show_position.global_position, smooth_duration)
	tween.tween_callback(callback)

func smooth_hide(callback: Callable = Callable()) -> void:
	_stop_tween_if_needed()
	tween = create_tween()
	tween.tween_property(self, "global_position", hide_position.global_position, smooth_duration)
	tween.tween_callback(hide)
	tween.tween_callback(callback)

func _stop_tween_if_needed() -> void:
	if tween:
		tween.stop()

func update_sticker_positions() -> void:
	for index in get_child_count():
		var child := get_child(index)
		child.position = get_position_by_index(index)

func get_position_by_index(index: int) -> Vector3:
	var hand_size := get_child_count() * sticker_width
	var offset := sticker_width * index
	var start_position := offset - (hand_size - sticker_width) / 2
	return Vector3(start_position, 0, 0)
