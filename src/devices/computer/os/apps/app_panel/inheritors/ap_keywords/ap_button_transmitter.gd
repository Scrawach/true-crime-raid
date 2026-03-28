class_name APButtonTransmitter
extends Button

var keyword:KeywordData

func _get_drag_data(at_position):
	var preview = Label.new()
	preview.text = text
	set_drag_preview(preview)
	return keyword
