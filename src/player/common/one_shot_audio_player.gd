class_name OneShotAudioPlayer
extends AudioStreamPlayer

func _physics_process(_delta: float) -> void:
	if not playing:
		queue_free()

static func make_from(data: AudioStream, parent: Node) -> OneShotAudioPlayer:
	var one_shot := OneShotAudioPlayer.new()
	one_shot.stream = data
	parent.add_child(one_shot)
	one_shot.play()
	return one_shot
