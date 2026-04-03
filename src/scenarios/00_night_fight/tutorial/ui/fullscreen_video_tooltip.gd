class_name FullscreenVideoTooltip
extends PanelContainer

@onready var accept_button: Button = %"Accept Button"
@onready var video_player: VideoStreamPlayer = %VideoPlayer

func _ready() -> void:
	accept_button.pressed.connect(stop)

func start() -> void:
	video_player.play()
	show()

func stop() -> void:
	video_player.stop()
	hide()
