class_name MonitorControl
extends Control

signal exited

@export var mouse_cursor: ComputerMouseCursor
@export var app_buttons:Array[Button]
@export var app_buttons_bottom:Array[Button]
@export var app_panels:Array[AppPanel]

@onready var btn_exit: Button = %btn_exit

func _ready() -> void:
	btn_exit.pressed.connect(exited.emit)
	apps_initialiazation()

func power_on() -> void:
	pass

func power_off() -> void:
	pass

func apps_initialiazation():
	for i in range(len(app_buttons)):
		app_buttons[i].pressed.connect(open_app.bind(app_panels[i], app_buttons_bottom[i]))
		app_panels[i].btn_label.text = app_buttons_bottom[i].text
		app_panels[i].btn_close.pressed.connect(close_app.bind(app_panels[i], app_buttons_bottom[i]))
		app_buttons_bottom[i].pressed.connect(app_panels[i].show_on_top.bind(true))


func open_app(app_panel:AppPanel, btn_bottom:Button):
	app_panel.show()
	btn_bottom.show()

func close_app(app_panel:AppPanel, btn_bottom:Button):
	app_panel.hide()
	btn_bottom.hide()
