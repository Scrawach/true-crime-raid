class_name WorkbenchAddPanel
extends PanelContainer

@onready var timed_panel: TimedPanel = $TimedPanel

func smooth_show() -> void:
	timed_panel.timed_show()

func smooth_hide() -> void:
	pass
