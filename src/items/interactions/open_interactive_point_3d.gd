class_name OpenInteractivePoint3D
extends InteractivePoint3D

@export var open_item: BaseItem

func _on_clicked() -> void:
	super._on_clicked()
	disable()
