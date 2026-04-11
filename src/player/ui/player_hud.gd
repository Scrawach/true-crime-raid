class_name PlayerHUD
extends CanvasLayer

@export var player: PlayerBody3D

@onready var center_container: CenterContainer = %CenterContainer
@onready var item_handle_tooltip: PanelContainer = %"Item Handle Tooltip"
@onready var menu_container: PanelContainer = %"Menu Container"

@onready var continue_button: Button = %"Continue Button"

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)

func show_aim_pointer() -> void:
	center_container.show()

func hide_aim_pointer() -> void:
	center_container.hide()

func show_item_handle_tooltip() -> void:
	item_handle_tooltip.show()

func hide_item_handle_tooltip() -> void:
	item_handle_tooltip.hide()

func _on_continue_pressed() -> void:
	menu_container.hide()
	player.mouse.capture()
