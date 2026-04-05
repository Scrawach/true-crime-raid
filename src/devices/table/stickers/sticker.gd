class_name Sticker
extends Area3D

@export var pin_node: Node3D
@export var data: TableStickerData

@onready var sticker_label: Label = %"Sticker Label"
@onready var sticker_texture: TextureRect = %"Sticker Texture"

func initialize(new_data: TableStickerData) -> void:
	data = new_data
	sticker_label.text = new_data.name
	sticker_texture.texture = new_data.photo

func pin() -> void:
	pin_node.show()

func unpin() -> void:
	pin_node.hide()
