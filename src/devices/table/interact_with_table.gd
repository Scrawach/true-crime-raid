class_name InteractWithTable
extends InteractWithDevice

@export var sticker_hand: StickerHand
@export var label_3d: Label3D
@export var table_sticker_dragging: DragAndDrop3D
@export var initializer: TableInitializer

func _ready() -> void:
	camera_move_stopped.connect(_on_camera_stopped)

func start_interaction(target: PlayerBody3D) -> void:
	super.start_interaction(target)
	label_3d.show()
	label_3d.text = "Найдено элементов: %s" % initializer.get_found_string()
	table_sticker_dragging.enable()

func stop_interaction() -> void:
	table_sticker_dragging.disable()
	sticker_hand.hide()
	sticker_hand.smooth_hide()
	label_3d.hide()
	super.stop_interaction()

func _on_camera_stopped() -> void:
	if not is_interacted:
		return
	sticker_hand.smooth_show()
