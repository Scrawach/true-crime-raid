class_name APButtonReciever
extends Button

var expected_keyword:KeywordData
var current_keyword:KeywordData

func _can_drop_data(at_position, data):
	if data != null and data is KeywordData:
		return expected_keyword.type == data.type
	else:
		return false

func _drop_data(at_position, data):
	current_keyword = data
	text = data.words
