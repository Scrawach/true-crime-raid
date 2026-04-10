class_name InteractWithTrashHolder
extends Node

@export var trash_scene: PackedScene
@export var interaction: Area3D
@export var destroy_area: Area3D

func _ready() -> void:
	destroy_area.body_entered.connect(_on_body_destroy_entered)

func _on_body_destroy_entered(body: Node3D) -> void:
	if body.scene_file_path != trash_scene.resource_path:
		return
	body.queue_free()
