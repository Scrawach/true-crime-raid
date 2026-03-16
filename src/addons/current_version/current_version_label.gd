@tool
class_name CurrentVersionLabel
extends Label

@export var show_datetime: bool:
	set(value):
		show_datetime = value
		_update_label_text()

func _ready() -> void:
	_update_label_text()

func _update_label_text() -> void:
	var version := CurrentVersion.get_version_string()
	var datetime := CurrentVersion.get_datetime_string()
	var label_text := "v%s" % version
	
	if show_datetime:
		label_text += " %s" % datetime
	
	text = label_text
	reset_size()
