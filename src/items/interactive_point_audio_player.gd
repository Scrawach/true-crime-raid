class_name InteractivePointAudioPlayer
extends AudioStreamPlayer

@export var point: InteractivePoint3D

func _ready() -> void:
	point.clicked.connect(_on_clicked)

func _on_clicked(_p: InteractivePoint3D) -> void:
	OneShotAudioPlayer.make_from(stream, get_tree().root).volume_db = volume_db
