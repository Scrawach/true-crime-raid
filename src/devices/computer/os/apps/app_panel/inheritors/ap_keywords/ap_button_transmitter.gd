class_name APButtonTransmitter
extends Button

var keyword:KeywordData

func _get_drag_data(at_position):
	var preview = duplicate()
	set_drag_preview(preview)
	return keyword
