class_name TableInitializer
extends Node

@export var directory_path: String
@export var hand: StickerHand
@export var sticker_scene: PackedScene

var all_stickers: Array[TableStickerData]
var found_stickers: Array[TableStickerData]

func _ready() -> void:
	GameManager.keyword_found.connect(_on_keyword_found)
	GameManager.dna_investigated.connect(_on_dna_investigated)
	initialize()

func _on_keyword_found(keyword: KeywordData) -> void:
	for sticker in all_stickers:
		if sticker.keyword_id == keyword.id and not sticker in found_stickers:
			found_stickers.append(sticker)
			make_sticker(sticker)

func _on_dna_investigated(dna: DNAData) -> void:
	for sticker in all_stickers:
		if sticker.dna_id == dna.id and not sticker in found_stickers:
			found_stickers.append(sticker)
			make_sticker(sticker)

func initialize() -> void:
	all_stickers = load_all_stickers_data(directory_path)

func get_found_string() -> String:
	return "%s / %s" % [found_stickers.size(), all_stickers.size()]

func make_sticker(data: TableStickerData) -> Sticker:
	var instance := sticker_scene.instantiate() as Sticker
	hand.add_child(instance)
	hand.update_sticker_positions()
	instance.initialize(data)
	return instance

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
