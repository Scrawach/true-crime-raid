extends AppPanel

@onready var hfc_words: HFlowContainer = $VBoxContainer/Content/hfc_words

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	GameManager.keywords_updated.connect(on_keywords_updated)
	clear_container()
	fill_container()


func on_keywords_updated():
	clear_container()
	fill_container()


func clear_container():
	for child in hfc_words.get_children():
		child.queue_free()


func fill_container():
	for keyword_data in GameManager.found_keywords.values():
		hfc_words.add_child(create_keyword_button(keyword_data))


func create_keyword_button(keyword_data:KeywordData) -> Button:
	var btn = APButton.new()
	btn.text = keyword_data.words
	return btn
