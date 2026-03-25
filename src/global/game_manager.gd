extends Node

signal keywords_updated
signal dna_investigated(dna_data:DNAData)

var found_keywords:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var kd1 = KeywordData.from_dict({
		"id":"x001",
		"text":"Jhon Doe",
		"type":"PERSON",
	})
	found_keywords[kd1.id] = kd1
	var kd2 = KeywordData.from_dict({
		"id":"x002",
		"text":"Конфликт",
		"type":"EVENT",
	})
	found_keywords[kd2.id] = kd2
	var kd3 = KeywordData.from_dict({
		"id":"x003",
		"text":"Стакан",
		"type":"EVIDENCE",
	})
	found_keywords[kd3.id] = kd3
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_keywords(keywords:Dictionary):
	found_keywords = keywords
	keywords_updated.emit()
