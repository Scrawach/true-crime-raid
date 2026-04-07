class_name StickerHand
extends Node3D

@export var sticker_width: float = 0.25

var offset: float

func _ready() -> void:
	update_sticker_positions()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_down"):
		if offset > 0:
			offset = 0
		offset -= 1
	elif event.is_action_pressed("scroll_up"):
		if offset < 0:
			offset = 0
		offset += 1

func _physics_process(delta: float) -> void:
	var step = delta * offset
	position.x += step
	
	var max_size := get_hand_size();
	position.x = clamp(position.x, - max_size / 2, max_size /2)
	offset = move_toward(offset, 0, delta * 10)

func update_sticker_positions() -> void:
	for index in get_child_count():
		var child := get_child(index)
		child.position = get_position_by_index(index)

func get_hand_size() -> float:
	return get_child_count() * sticker_width

func get_position_by_index(index: int) -> Vector3:
	var hand_size := get_child_count() * sticker_width
	var offset := sticker_width * index
	var start_position := offset - (hand_size - sticker_width) / 2
	return Vector3(start_position, 0, 0)
