class_name DNAInteractivePoint3D
extends InteractivePoint3D

@export var dna_data: DNAData
@export var only_once: bool
@export var dna_mesh: Node3D

@export var uv_required: bool
@export var uv_material: StandardMaterial3D
@export var uv_mesh: MeshInstance3D

func _on_clicked() -> void:
	super._on_clicked()
	
	if only_once:
		dispose_dna()
	else:
		disable()

func dispose_dna() -> void:
	if dna_mesh:
		dna_mesh.queue_free()
	queue_free()

func uv_enable() -> void:
	uv_mesh.material_override = uv_material

func uv_disable() -> void:
	uv_mesh.material_override = null
