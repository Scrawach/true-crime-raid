class_name KeywordDatabase
extends RefCounted

static var instance: KeywordDatabase:
	get():
		if instance == null:
			instance = KeywordDatabase.new()
		return instance

signal added(keyword: KeywordData)
signal removed(keyword: KeywordData)

var keywords: Dictionary[String, KeywordData]

func get_keyword(id: String) -> KeywordData:
	return keywords.get(id)

func add_keyword(data: KeywordData) -> void:
	keywords[data.id] = data
	added.emit(data)

func remove_keyword(id: String) -> void:
	var keyword: KeywordData = keywords.get(id, null)
	if keyword != null:
		keywords.erase(id)
		removed.emit(keyword)

func has_keyword(id: String) -> bool:
	return keywords.has(id)
