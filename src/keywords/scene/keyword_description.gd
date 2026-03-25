class_name KeywordDescription
extends PanelContainer

signal keyword_clicked(keyword: KeywordData)

@onready var header_label: Label = %"Header Label"
@onready var keyword_text_label: KeywordTextLabel = %KeywordTextLabel

func _ready() -> void:
	keyword_text_label.keyword_clicked.connect(keyword_clicked.emit)

func initialize(header: String, content: String) -> void:
	header_label.text = header
	keyword_text_label.text = content
	keyword_text_label.initialize()

func get_keyword_count() -> int:
	return keyword_text_label.get_keyword_count()

func get_all_keywords() -> Array[KeywordData]:
	return keyword_text_label.get_all_keywords()
