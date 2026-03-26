class_name DNAData
extends Resource

@export var database_name: String
@export var overlap_percentage: float
@export_enum("Null", "Partial", "Direct") var match_type: String
@export_multiline var description: String

var is_processed: bool

func get_content_string() -> String:
	if not is_processed:
		return ""
	return "Имя: %s\nРезультат: %.2f%%\nСовпадение: %s" % [_get_name(), overlap_percentage, _get_match_string(match_type)]

func _get_name() -> String:
	if database_name.is_empty():
		return "НЕИЗВЕСТНО"
	return database_name

func _get_match_string(base: String) -> String:
	if base == "Partial":
		return "ЧАСТИЧ."
	if base == "Direct":
		return "ПРЯМОЕ"
	return "НЕТ"
