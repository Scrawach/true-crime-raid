class_name InteractWithTubesStand
extends Node

@export var interaction: InteractionArea3D
@export var handle_points: Node3D

var free_points: Array[Node3D]
var closed_points: Dictionary[Node3D, DNAItem]

func _ready() -> void:
	interaction.interacted.connect(_on_interacted)
	initialize()

func _on_interacted(body: PlayerBody3D) -> void:
	if body.hand.is_empty():
		player_take_dna(body.hand)
	else:
		player_put_dna(body.hand)

func initialize() -> void:
	for point in handle_points.get_children():
		free_points.append(point)

func has_tubes() -> bool:
	return not closed_points.is_empty()

func player_take_dna(hand: PlayerHand) -> void:
	hand.pickup(take_dna())

func take_dna() -> DNAItem:
	var random_point: Node3D = closed_points.keys().pick_random()
	var random_dna := closed_points[random_point]
	closed_points.erase(random_point)
	free_points.append(random_point)
	return random_dna

func put_dna(dna: DNAItem) -> void:
	var random_point: Node3D = free_points.pick_random()
	free_points.erase(random_point)
	closed_points[random_point] = dna
	dna.reparent(random_point)
	dna.position = Vector3.ZERO
	dna.rotation = Vector3.ZERO
	dna.grab()

func player_put_dna(hand: PlayerHand) -> void:
	if not hand.item is DNAItem:
		return
	
	var player_dna := hand.item
	hand.drop()
	put_dna(player_dna)
