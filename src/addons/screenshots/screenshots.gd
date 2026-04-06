class_name Screenshots
extends Node

@onready var scene_path_label: Label = %"Scene Path Label"
@onready var opene_scene_button: Button = %"Opene Scene Button"
@onready var file_dialog: FileDialog = %FileDialog

@onready var point: Node3D = %Point

@onready var distance: LineEdit = %Distance
@onready var rot_x: LineEdit = %RotX
@onready var rot_y: LineEdit = %RotY
@onready var rot_z: LineEdit = %RotZ

@onready var offset_x: LineEdit = %OffsetX
@onready var offset_y: LineEdit = %OffsetY



@onready var update_button: Button = %"Update Button"
@onready var make_button: Button = %"Make Button"

@onready var sub_viewport: SubViewport = %SubViewport

func _ready() -> void:
	opene_scene_button.pressed.connect(_on_open_pressed)
	file_dialog.file_selected.connect(_on_file_selected)
	update_button.pressed.connect(_on_update_pressed)
	make_button.pressed.connect(_on_make_pressed)

func _on_open_pressed() -> void:
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.popup_centered()

func _on_file_selected(path: String) -> void:
	if file_dialog.file_mode == FileDialog.FILE_MODE_OPEN_FILE:
		_process_load_file(path)
	else:
		_process_save_screenshot(path)

func _process_load_file(path: String) -> void:
	for child in point.get_children():
		child.queue_free()
	
	var resource: PackedScene = load(path)
	var node := resource.instantiate() as Node3D
	_disable_physics_if_exist(node)
	point.add_child(node)
	_on_update_pressed()

func _process_save_screenshot(path: String) -> void:
	print("SAVE TO: %s" % path)
	var image := make_screenshot()
	image.save_png(path)

func _disable_physics_if_exist(target: Node3D) -> void:
	if target is RigidBody3D:
		target.freeze = true

func _on_update_pressed() -> void:
	point.position.z = -float(distance.text)
	point.rotation_degrees = _get_rotation()
	
	point.position.x = float(offset_x.text)
	point.position.y = float(offset_y.text)

func _get_rotation() -> Vector3:
	var x := float(rot_x.text)
	var y := float(rot_y.text)
	var z := float(rot_z.text)
	return Vector3(x, y, z)

func _on_make_pressed() -> void:
	file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	file_dialog.popup_centered()

func make_screenshot() -> Image:
	sub_viewport.transparent_bg = true
	var texture := sub_viewport.get_texture()
	var image := texture.get_image()
	image.convert(Image.FORMAT_RGBA8)
	return image
