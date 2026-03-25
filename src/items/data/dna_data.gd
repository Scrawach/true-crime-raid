class_name DNAData
extends Resource

@export var database_name: String
@export var overlap_percentage: float
@export_enum("Null", "Partial", "Direct") var match_type: String
@export_multiline var description: String

var is_processed: bool
