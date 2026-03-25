class_name KeywordsPanel
extends PanelContainer

@onready var keywords_count: Label = %"Keywords Count"
@onready var keywords_container: HFlowContainer = %"Keywords Container"

var found_keywords: Dictionary[String, KeywordData]
var keywords_max_count: int

func initialize(max_count: int) -> void:
	keywords_max_count = max_count
	update_count(0, max_count)

func fill(keywords: Array[KeywordData]) -> void:
	for keyword in keywords:
		add_keyword(keyword)

func update_count(current: int, max_count: int) -> void:
	keywords_count.text = "%s / %s" % [current, max_count]

func add_keyword(data: KeywordData) -> void:
	if found_keywords.has(data.id):
		return
	
	found_keywords[data.id] = data
	update_count(found_keywords.size(), keywords_max_count)
	var flow_label := make_label_for(data)
	keywords_container.add_child(flow_label)

func make_label_for(keyword: KeywordData) -> Label:
	var key_label := Label.new()
	key_label.uppercase = true
	key_label.text = keyword.words
	return key_label

func clear() -> void:
	keywords_count.text = ""
	found_keywords.clear()
	for child in keywords_container.get_children():
		child.queue_free()
