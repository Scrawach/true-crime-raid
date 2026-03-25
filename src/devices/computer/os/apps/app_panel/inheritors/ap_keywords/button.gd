class_name APButton
extends Button

func _get_drag_data(at_position):
	var preview = duplicate()
	set_drag_preview(preview)
	return text
