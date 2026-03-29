class_name FindKeywordCountTutorial
extends QuestSubstageData

@export var target_count: int

var found_keywords: Array[KeywordData]

func start() -> void:
	KeywordDatabase.instance.added.connect(_on_keyword_added)

func _on_keyword_added(keyword: KeywordData) -> void:
	if found_keywords.has(keyword):
		return
	
	found_keywords.append(keyword)
	var found_count := found_keywords.size()
	
	update()
	
	if found_count >= target_count:
		finish()

func stop() -> void:
	KeywordDatabase.instance.added.disconnect(_on_keyword_added)

func get_result_string() -> String:
	return "%s / %s" % [found_keywords.size(), target_count]

static func create(description: String, target: int) -> FindKeywordCountTutorial:
	var data := FindKeywordCountTutorial.new()
	data.name = description
	data.target_count = target
	return data
