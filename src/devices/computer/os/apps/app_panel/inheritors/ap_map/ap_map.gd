class_name APMap
extends AppPanel

@export var image:Texture2D

@export var max_zoom := 2.0
@export var min_zoom := 0.5
@export var zoom_step := 0.1

@onready var c_hinge: Control = %c_hinge
@onready var p_mouse_catcher: Panel = %p_mouse_catcher

var mouse_hovering = false
var mmb_pressed = false

var person_buttons:Dictionary[String, Button]
var evidence_buttons:Dictionary[String, Button]
var dna_lines:Dictionary[String, Line2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	GameManager.keyword_found.connect(on_keyword_found)
	GameManager.dna_investigated.connect(on_dna_investigated)


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

func registrate_ui_elements():
	#
	person_buttons = {}
	evidence_buttons = {}
	dna_lines = {}
	#
	for node in get_tree().get_nodes_in_group("os_map_btn_evidence"):
		if node.has_meta("evidence_id"):
			evidence_buttons[node.get_meta("evidence_id")] = node
	for node in get_tree().get_nodes_in_group("os_map_btn_person"):
		if node.has_meta("person_id"):
			person_buttons[node.get_meta("person_id")] = node
	for node in get_tree().get_nodes_in_group("os_map_l2d_dna"):
		if node.has_meta("dna_id"):
			dna_lines[node.get_meta("dna_id")] = node
	#
	for btn in evidence_buttons.values():
		btn.hide()
	for l2d in dna_lines.values():
		l2d.hide()
		
func synchronize_keywords(keywords_pool:Dictionary[KeywordData, bool]):
	#TO DO
	pass

func _on_btn_center_pressed() -> void:
	c_hinge.position = Vector2.ZERO
	c_hinge.scale = Vector2.ONE

func on_keyword_found(kw:KeywordData):
	#
	if kw.type == "evidence":
		if kw.id in evidence_buttons.keys():
			evidence_buttons[kw.id].show()
	#
	if kw.type == "person":
		if kw.id in person_buttons.keys():
			person_buttons[kw.id].text = kw.words.replace(" ", "\n")
			person_buttons[kw.id].icon = image
	

func on_dna_investigated(dna:DNAData):
	if dna.id in dna_lines.keys():
		dna_lines[dna.id].show()

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
