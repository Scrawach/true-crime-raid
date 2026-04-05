class_name InteractWithTable
extends InteractWithDevice

@export var sticker_hand: StickerHand
@export var label_3d: Label3D

func _ready() -> void:
	camera_move_stopped.connect(_on_camera_stopped)

func start_interaction(target: PlayerBody3D) -> void:
	super.start_interaction(target)
	label_3d.show()

func stop_interaction() -> void:
	sticker_hand.smooth_hide()
	label_3d.hide()
	super.stop_interaction()

func _on_camera_stopped() -> void:
	if not is_interacted:
		return
	sticker_hand.smooth_show()
