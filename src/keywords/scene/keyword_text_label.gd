class_name KeywordTextLabel
extends RichTextLabel

signal keyword_clicked(keyword: KeywordData)

var keyword_effect := KeywordRichTextEffect.new()
var keywords_cache: Dictionary[String, KeywordData]

func _ready() -> void:
	meta_underlined = false
	bbcode_enabled = true
	
	keyword_effect.clicked_color = Color.FIREBRICK
	keyword_effect.normal_color = Color.AQUAMARINE
	keyword_effect.hover_color = Color.BISQUE
	install_effect(keyword_effect)
	
	meta_clicked.connect(_on_meta_clicked)
	meta_hover_started.connect(_on_meta_hovered)
	meta_hover_ended.connect(_on_meta_unhovered)
	finished.connect(_on_finished)

func initialize() -> void:
	var keywords := BBCodeParser.get_all("keyword", text)
	for keyword in keywords:
		var id: String = keyword["id"]
		keywords_cache[id] = KeywordData.from_dict(keyword)
		if KeywordDatabase.instance.has_keyword(id):
			keyword_effect.click(id)

func get_keyword_count() -> int:
	if not is_finished():
		initialize()
	return keywords_cache.size()

func _on_finished() -> void:
	initialize()

func _on_meta_clicked(meta: Variant) -> void:
	keyword_effect.click(meta)
	
	if keywords_cache.has(meta):
		var keyword := keywords_cache[meta]
		KeywordDatabase.instance.add_keyword(keyword)
		keyword_clicked.emit(keyword)

func _on_meta_hovered(meta: Variant) -> void:
	keyword_effect.hover(meta)

func _on_meta_unhovered(meta: Variant) -> void:
	keyword_effect.unhover(meta)
