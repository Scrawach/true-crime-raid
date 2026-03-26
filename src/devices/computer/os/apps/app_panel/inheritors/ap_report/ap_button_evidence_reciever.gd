class_name APButtonEvidenceReciever
extends Button

signal data_dropped(data)

func _can_drop_data(at_position, data):
	if data != null and data is KeywordData:
		return data.type == "EVIDENCE"
	else:
		return false

func _drop_data(at_position, data):
	data_dropped.emit(data)
