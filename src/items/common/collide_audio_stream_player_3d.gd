class_name CollideAudioStreamPlayer3D
extends AudioStreamPlayer3D

@export var body: RigidBody3D
@export var desired_velocity := 0.5
@export var velocity_volume_factor := 10.0
var init_volume: float

func _ready() -> void:
	body.body_entered.connect(_on_body_entered)
	init_volume = volume_db

func _on_body_entered(_b: Node) -> void:
	var velocity := body.linear_velocity.length()
	
	if velocity < desired_velocity:
		return
	
	var volume_factor := velocity / desired_velocity - 1
	volume_db = init_volume + volume_factor * velocity_volume_factor
	play()
