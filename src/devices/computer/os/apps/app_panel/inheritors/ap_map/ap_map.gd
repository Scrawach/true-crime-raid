class_name APMap
extends AppPanel

@export var max_zoom := 2.0
@export var min_zoom := 0.5
@export var zoom_step := 0.1

@onready var c_hinge: Control = %c_hinge
@onready var p_mouse_catcher: Panel = %p_mouse_catcher

var mouse_hovering = false
var mmb_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	mouse_hovering = p_mouse_catcher.get_global_rect().has_point(get_global_mouse_position())


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE:
		mmb_pressed = event.pressed
	if mouse_hovering:
		if event is InputEventMouseMotion:
			if mmb_pressed:
				c_hinge.position += event.relative
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_in()
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_out()


func _on_btn_center_pressed() -> void:
	c_hinge.position = Vector2.ZERO
	c_hinge.scale = Vector2.ONE


func zoom_at_cursor(factor: float) -> void:
	#
	var mouse_pos = get_global_mouse_position()
	var before = mouse_pos - c_hinge.global_position
	before /= c_hinge.scale
	#
	c_hinge.scale += Vector2.ONE*factor
	c_hinge.scale = clamp(c_hinge.scale + Vector2.ONE*factor, Vector2.ONE*min_zoom, Vector2.ONE*max_zoom)
	#
	var after = mouse_pos - c_hinge.global_position
	after /= c_hinge.scale
	c_hinge.global_position += (after - before) * c_hinge.scale


func zoom_in() -> void:
	zoom_at_cursor(zoom_step)


func zoom_out() -> void:
	zoom_at_cursor(-zoom_step)
