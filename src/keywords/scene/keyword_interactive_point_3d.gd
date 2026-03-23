class_name KeywordInteractivePoint3D
extends InteractivePoint3D

@export var data: KeywordData

func _on_clicked() -> void:
	super._on_clicked()
	disable()
