class_name KeywordData
extends Resource

@export var id: String
@export var words: String
@export var type: String

func is_found() -> bool:
	return KeywordDatabase.instance.has_keyword(id)

static func from_dict(dict: Dictionary) -> KeywordData:
	var keyword := KeywordData.new()
	keyword.id = dict.get("id", "")
	keyword.words = dict.get("text", "")
	keyword.type = dict.get("type", "")
	return keyword

func _to_string() -> String:
	return "K\"%s\" (%s)" % [words, id]
