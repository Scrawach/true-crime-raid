extends Node

signal keyword_found(kw:KeywordData)
signal dna_investigated(dna_data:DNAData)

signal case_complited

signal replay_case_requested
signal next_case_requested

func _ready() -> void:
	KeywordDatabase.instance.added.connect(keyword_found.emit)
