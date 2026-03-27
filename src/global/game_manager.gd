extends Node

signal keyword_found(kw:KeywordData)
signal dna_investigated(dna_data:DNAData)

func _ready() -> void:
	KeywordDatabase.instance.added.connect(keyword_found.emit)
