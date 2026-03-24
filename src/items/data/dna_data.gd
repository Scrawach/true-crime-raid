class_name DNAData
extends Resource

@export var database_name: String
@export var overlap_ratio: float

func get_overlap_precentage() -> float:
	return overlap_ratio * 100
