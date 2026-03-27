class_name KeywordItemPanel
extends PanelContainer

@export var type_colors: Dictionary[String, Color]
@export var type_icons: Dictionary[String, Texture2D]

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label

func initialize(keyword: KeywordData) -> void:
	label.text = keyword.words.to_upper()
	texture_rect.texture = _get_icon_from_type(keyword.type)
	self_modulate = _get_color_from_type(keyword.type)
	reset_size()

func _get_color_from_type(type: String) -> Color:
	return type_colors.get(type, Color.BLACK)

func _get_icon_from_type(type: String) -> Texture2D:
	return type_icons.get(type, null)
