class_name FindKeywordCountTutorial
extends QuestSubstageData

@export var target: Array[KeywordData]

var found_keywords: Array[KeywordData]

func start() -> void:
	KeywordDatabase.instance.added.connect(_on_keyword_added)

func _on_keyword_added(keyword: KeywordData) -> void:
	if found_keywords.has(keyword) or not _has_this_keyword_as_target(keyword):
		return
	
	found_keywords.append(keyword)
	var found_count := found_keywords.size()
	
	update()
	
	if found_count >= target.size():
		finish()

func _has_this_keyword_as_target(keyword: KeywordData) -> bool:
	for data in target:
		if data.id == keyword.id:
			return true
	return false

func stop() -> void:
	KeywordDatabase.instance.added.disconnect(_on_keyword_added)

func get_result_string() -> String:
	return "%s / %s" % [found_keywords.size(), target.size()]

static func create(description: String, keywords: Array[KeywordData]) -> FindKeywordCountTutorial:
	var data := FindKeywordCountTutorial.new()
	data.name = description
	data.target = keywords
	return data
