class_name InteractWithTrashHolder
extends Node

const OPEN_ANIMATION := &"open"

@export var trash_scene: PackedScene
@export var interaction: Area3D
@export var destroy_area: Area3D
@export var animation: AnimationPlayer

func _ready() -> void:
	interaction.body_entered.connect(_on_body_entered)
	interaction.body_exited.connect(_on_body_exited)
	destroy_area.body_entered.connect(_on_body_destroy_entered)

func _on_body_entered(_body: Node3D) -> void:
	animation.play(OPEN_ANIMATION)

func _on_body_exited(_body: Node3D) -> void:
	animation.play_backwards(OPEN_ANIMATION)

func _on_body_destroy_entered(body: Node3D) -> void:
	if body.scene_file_path != trash_scene.resource_path:
		return
	body.queue_free()
