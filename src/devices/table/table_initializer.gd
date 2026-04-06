class_name TableInitializer
extends Node

@export var directory_path: String
@export var hand: StickerHand
@export var sticker_scene: PackedScene

func _ready() -> void:
	initialize()

func initialize() -> void:
	for data in load_all_stickers_data(directory_path):
		var sticker := sticker_scene.instantiate() as Sticker
		hand.add_child(sticker)
		sticker.initialize(data)
	hand.update_sticker_positions()

static func load_all_stickers_data(directory: String) -> Array[TableStickerData]:
	const RESOURCE_FORMAT := "tres"
	var stickers: Array[TableStickerData]
	for file_name in ResourceLoader.list_directory(directory):
		if file_name.get_extension() != RESOURCE_FORMAT:
			continue
		var resource = load(directory.path_join(file_name))
		if resource is TableStickerData:
			stickers.append(resource)
	return stickers
