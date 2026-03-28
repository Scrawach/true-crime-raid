class_name FindKeywordCountTutorial
extends QuestSubstageData

@export var target_count: int

var found_count: int

func start() -> void:
	KeywordDatabase.instance.added.connect(_on_keyword_added)

func _on_keyword_added(_keyword: KeywordData) -> void:
	found_count += 1
	
	update()
	
	if found_count >= target_count:
		finish()

func stop() -> void:
	KeywordDatabase.instance.added.disconnect(_on_keyword_added)

func get_result_string() -> String:
	return "%s / %s" % [found_count, target_count]

static func create(description: String, target: int) -> FindKeywordCountTutorial:
	var data := FindKeywordCountTutorial.new()
	data.name = description
	data.target_count = target
	return data
