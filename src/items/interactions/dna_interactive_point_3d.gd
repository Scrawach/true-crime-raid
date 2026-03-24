class_name DNAInteractivePoint3D
extends InteractivePoint3D

@export var dna_data: DNAData

func _on_clicked() -> void:
	super._on_clicked()
	disable()
