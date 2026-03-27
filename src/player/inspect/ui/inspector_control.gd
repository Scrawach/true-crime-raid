class_name InspectorControl
extends Control

@export var sub_viewport_container: SubViewportContainer
@export var item_camera_3d: Camera3D

@onready var control_container: Control = %"Control Container"
@onready var keyword_description: KeywordDescription = %"Keyword Description"
@onready var keywords_panel: KeywordsPanel = %"Keywords Panel"

@onready var dna_count: PanelContainer = %"DNA Count"
@onready var dna_count_label: Label = %"DNA Count Label"

var item: BaseItem

func _ready() -> void:
	keyword_description.keyword_clicked.connect(add_text_keyword)

func initialize(base_item: BaseItem) -> void:
	item = base_item
	_update_item_description(item)

func clear() -> void:
	keywords_panel.clear()

func add_keyword(point: InteractivePoint3D, data: KeywordData) -> void:
	spawn_smooth_label(data, _get_screen_position(point.global_position))
	keywords_panel.add_keyword(data)

func add_text_keyword(data: KeywordData) -> void:
	keywords_panel.add_keyword(data)

func _update_item_description(target: BaseItem) -> void:
	if target.data == null:
		keyword_description.initialize("", "")
		keyword_description.hide()
		return
	keyword_description.show()
	keyword_description.initialize(target.data.name, target.get_description())
	
	if get_max_keyword_count() == 0:
		keywords_panel.hide()
	else:
		keywords_panel.show()
		keywords_panel.initialize(get_max_keyword_count())
		keywords_panel.fill(get_found_keywords())
	
	_update_dna_info(target)

func _update_dna_info(target: BaseItem) -> void:
	var total := target.total_dna_points
	
	if total == 0:
		dna_count.hide()
	else:
		dna_count.show()
	
	var found_count := total - target.get_dna_interactive_points().size()
	dna_count_label.text = "%s / %s" % [found_count, total]

func _get_screen_position(pos_3d: Vector3) -> Vector2:
	return sub_viewport_container.global_position + item_camera_3d.unproject_position(pos_3d)

func spawn_smooth_label(keyword: KeywordData, pos: Vector2) -> void:
	var key_label := make_label_for(keyword)
	control_container.add_child(key_label)
	var rect = key_label.get_rect()
	key_label.position = pos - rect.size / 2
	var tween = key_label.create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(key_label, "position", key_label.position + Vector2.UP * 50, 1.0)
	tween.parallel().tween_property(key_label, "modulate:a", 0, 2)
	tween.tween_callback(key_label.queue_free)

func get_max_keyword_count() -> int:
	var sum := 0
	for child in item.get_interactive_points().get_children():
		if child is KeywordInteractivePoint3D:
			sum += 1
	return sum + keyword_description.get_keyword_count()

func get_keywords_from_interactive_points() -> Array[KeywordData]:
	var keywords: Array[KeywordData]
	for child in item.get_interactive_points().get_children():
		if child is KeywordInteractivePoint3D:
			keywords.append(child.data)
	return keywords

func get_found_keywords() -> Array[KeywordData]:
	var found_keywords: Array[KeywordData]
	for keyword in keyword_description.get_all_keywords():
		if keyword.is_found():
			found_keywords.append(keyword)
	for keyword in get_keywords_from_interactive_points():
		if keyword.is_found():
			found_keywords.append(keyword)
	return found_keywords

func make_label_for(keyword: KeywordData) -> Label:
	var key_label := Label.new()
	key_label.uppercase = true
	key_label.text = keyword.words
	return key_label
	
