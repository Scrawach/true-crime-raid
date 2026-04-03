class_name Workbench
extends Node3D

signal interaction_started()
signal interaction_stopped()

signal sample_taked(data: DNAData)

@onready var interact_with_workbench: InteractWithWorkbench = %InteractWithWorkbench

func _ready() -> void:
	interact_with_workbench.started.connect(interaction_started.emit)
	interact_with_workbench.stopped.connect(interaction_stopped.emit)
	interact_with_workbench.sample_taked.connect(sample_taked.emit)
