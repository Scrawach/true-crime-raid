class_name CaseResult
extends VBoxContainer

@export var holder:Control

@onready var btn_replay: Button = %btn_replay
@onready var btn_continue: Button = %btn_continue


func _ready() -> void:
	GameManager.case_complited.connect(holder.show)
	btn_replay.pressed.connect(request_case_replay)
	btn_continue.pressed.connect(request_next_case)


func request_next_case():
	GameManager.next_case_requested.emit()
	holder.hide()


func request_case_replay():
	GameManager.replay_case_requested.emit()
	holder.hide()
