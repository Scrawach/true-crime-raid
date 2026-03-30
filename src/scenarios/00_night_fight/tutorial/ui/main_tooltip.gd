class_name FullscreenTooltip
extends PanelContainer

@onready var accept_button: Button = %"Accept Button"

func _ready() -> void:
	accept_button.pressed.connect(hide)
