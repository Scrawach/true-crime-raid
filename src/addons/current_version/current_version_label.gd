@tool
class_name CurrentVersionLabel
extends Label

@export var show_commit_hash: bool = true:
	set(value):
		show_commit_hash = value
		_update_label_text()

@export var show_datetime: bool = true:
	set(value):
		show_datetime = value
		_update_label_text()

func _ready() -> void:
	_update_label_text()

func _update_label_text() -> void:
	var version := CurrentVersion.get_version_string()
	var label_text := "v%s" % version
	
	if show_commit_hash:
		label_text += " [%s]" % CurrentVersion.get_commit_hash()
	
	if show_datetime:
		label_text += " %s" % CurrentVersion.get_datetime_string()
	
	text = label_text
	reset_size()
