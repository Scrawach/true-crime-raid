extends Button


func _can_drop_data(at_position, data):
	return data != null

func _drop_data(at_position, data):
	text = str(data)
