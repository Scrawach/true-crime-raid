class_name AppPanel
extends PanelContainer

@export var btn_bottom:Button
@export var btn_ico:Button

@onready var btn_close: Button = %btn_close
@onready var btn_label: Button = %btn_label

var is_dragging = false
var drag_offset := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#
	btn_label.button_down.connect(start_dragging)
	btn_label.button_up.connect(stop_dragging)
	btn_close.pressed.connect(close)
	#
	if btn_bottom != null:
		btn_bottom.pressed.connect(show_on_top.bind(true))
		btn_bottom.hide()
	else:
		printerr(" to do - AppPanel - btn_bottom == null")
	#
	if btn_ico != null:
		btn_ico.pressed.connect(open)
	else:
		printerr(" to do - AppPanel - btn_ico == null")
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging:
		position = get_viewport().get_mouse_position() - drag_offset

func start_dragging():
	show_on_top()
	drag_offset = get_viewport().get_mouse_position() - position
	is_dragging = true
	
func stop_dragging():
	is_dragging = false

func show_on_top(set_center = false):
	get_parent().move_child(self, get_parent().get_child_count() - 1)
	if set_center:
		position = get_viewport().get_visible_rect().size/2-size/2
		
func open():
	show_on_top()
	show()
	btn_bottom.show()

func close():
	hide()
	btn_bottom.hide()
