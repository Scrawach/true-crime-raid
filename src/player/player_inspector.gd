class_name PlayerInspector
extends Node

@export var player: PlayerBody3D
@export var player_hand: PlayerHand
@export var inspect_item: InspectItem
@export var player_input: PlayerInput

var active: bool = false

func is_active() -> bool:
	return active

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inspect"):
		if is_active():
			abort()
		elif player_hand.has_item():
			inspect()

func inspect() -> void:
	inspect_item.player = player
	active = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player_input.disable()
	inspect_item.inspect(player_hand.item)

func abort() -> void:
	active = false
	player_hand.item = inspect_item.item
	player_hand.item.reparent(player_hand.hand_point)
	player_hand.item.position = Vector3.ZERO
	player_hand.item.rotation = Vector3.ZERO
	inspect_item.abort()
	player_input.enable()
	player_input.mouse_capture.capture()
