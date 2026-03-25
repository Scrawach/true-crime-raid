class_name PlayerHUD
extends CanvasLayer

@onready var center_container: CenterContainer = %CenterContainer
@onready var item_handle_tooltip: PanelContainer = %"Item Handle Tooltip"

func show_aim_pointer() -> void:
	center_container.show()

func hide_aim_pointer() -> void:
	center_container.hide()

func show_item_handle_tooltip() -> void:
	item_handle_tooltip.show()

func hide_item_handle_tooltip() -> void:
	item_handle_tooltip.hide()
