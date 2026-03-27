class_name APKeywords
extends AppPanel

@onready var hfc_kwbs_personas: HFlowContainer = %hfc_kwbs_personas
@onready var hfc_kwbs_events: HFlowContainer = %hfc_kwbs_events
@onready var hfc_kwbs_evidences: HFlowContainer = %hfc_kwbs_evidences

var keyword_buttons:Dictionary[KeywordData, APButtonTransmitter]


func clear_containers():
	for child in hfc_kwbs_personas.get_children():
		child.queue_free()
	for child in hfc_kwbs_events.get_children():
		child.queue_free()
	for child in hfc_kwbs_evidences.get_children():
		child.queue_free()


func fill_containers(data: Array[KeywordData]):
	for keyword_data in data:
		if keyword_data == null:
			printerr(" to do - APKeywords - fill_containers - keyword_data == null")
			continue
		match keyword_data.type:
			"person":
				hfc_kwbs_personas.add_child(create_keyword_button(keyword_data, keyword_data.is_found()))
			"event":
				hfc_kwbs_events.add_child(create_keyword_button(keyword_data, keyword_data.is_found()))
			"evidence":
				hfc_kwbs_evidences.add_child(create_keyword_button(keyword_data, keyword_data.is_found()))
			_:
				printerr(" to do - APKeywords - fill_containers - no type for keyword: ", keyword_data)


func create_keyword_button(keyword_data:KeywordData, _visible:bool) -> Button:
	var btn = APButtonTransmitter.new()
	keyword_buttons[keyword_data] = btn
	btn.text = keyword_data.words
	btn.visible = _visible
	btn.keyword = keyword_data
	return btn
