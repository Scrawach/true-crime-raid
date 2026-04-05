class_name TableStickerData
extends Resource

@export var id: String
@export var name: String
@export_multiline var description: String

@export var photo: Texture2D
@export var connections: Array[String]

@export var keyword_id: String
@export var dna_id: String

func _to_string() -> String:
	return "TSD: Id = %s (%s)" % [id, name]
