class_name Sticker
extends Area3D

@export var pin_node: Node3D
@export var data: TableStickerData

@export var mesh_data: Array[ArrayMesh]

@onready var sticker_background: ColorRect = %"Sticker Background"
@onready var sticker_label: Label = %"Sticker Label"
@onready var sticker_texture: TextureRect = %"Sticker Texture"
@onready var note_sticker_mesh: MeshInstance3D = %"Note Sticker Mesh"

var hover_tween: Tween

func _ready() -> void:
	note_sticker_mesh.mesh = mesh_data.pick_random()

func initialize(new_data: TableStickerData) -> void:
	data = new_data
	sticker_label.text = new_data.name
	sticker_texture.texture = new_data.photo
	sticker_background.color = new_data.color

func pin() -> void:
	pin_node.show()
	unhover()

func unpin() -> void:
	pin_node.hide()

func is_pinned() -> bool:
	return pin_node.visible

func move_to(target: Vector3) -> void:
	pass

func hover() -> void:
	_stop_tween_if_needed(hover_tween)
	if is_pinned():
		scale = Vector3.ONE
		return
	
	hover_tween = create_tween()
	hover_tween.tween_property(self, "scale", Vector3.ONE * 1.2, 0.15)

func unhover() -> void:
	_stop_tween_if_needed(hover_tween)
	if is_pinned():
		scale = Vector3.ONE
		return
	hover_tween = create_tween()
	hover_tween.tween_property(self, "scale", Vector3.ONE, 0.15)

func _stop_tween_if_needed(target: Tween) -> void:
	if target:
		target.custom_step(9999)
		target.kill()
