class_name StickerHolder
extends Node3D

@export var show_position: Node3D
@export var hide_position: Node3D
@export var smooth_duration: float = 0.4

@export var hand: StickerHand

var tween: Tween

var is_hand_empty: bool

func _ready() -> void:
	hand.child_entered_tree.connect(_on_child_entered)
	hand.child_exiting_tree.connect(_on_child_exited)
	is_hand_empty = hand.get_child_count() == 0

func _on_child_entered(_child: Node) -> void:
	is_hand_empty = hand.get_child_count() == 0

func _on_child_exited(_child: Node) -> void:
	is_hand_empty = (hand.get_child_count() - 1) <= 0

func smooth_show(callback: Callable = Callable()) -> void:
	if is_hand_empty:
		return
	
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
