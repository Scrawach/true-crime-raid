@tool
class_name QuestSubstagePanel
extends PanelContainer

@export var description: String:
	set(value):
		description = value
		if not is_node_ready():
			await ready
		quest_description.text = description
		
@export var result: String:
	set(value):
		result = value
		if not is_node_ready():
			await ready
		quest_target.text = result
		quest_target.visible = not result.is_empty()

@export var is_marked: bool:
	set(value):
		is_marked = value
		if not is_node_ready():
			await ready
		progress_texture.texture = mark_icon if is_marked else base_icon
		modulate = mark_color if is_marked else Color.WHITE

@export var base_icon: Texture2D
@export var mark_icon: Texture2D
@export var mark_color: Color

@onready var progress_texture: TextureRect = %"Progress Texture"
@onready var quest_description: Label = %"Quest Description"
@onready var quest_target: Label = %"Quest Target"

func initialize(data: QuestSubstageData) -> void:
	description = data.name
	result = data.get_result_string()
	data.updated.connect(_on_updated)
	data.finished.connect(_on_finished)

func _on_updated(stage: QuestSubstageData) -> void:
	description = stage.name
	result = stage.get_result_string()

func _on_finished(stage: QuestSubstageData) -> void:
	if is_marked:
		return
	
	is_marked = true

func remove() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 3.0)
	tween.tween_callback(queue_free)
