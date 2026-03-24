class_name InteractWithComputer
extends InteractWithDevice

@export var monitor_3d: Monitor3D
@export var computer_canvas: CanvasLayer

func _ready() -> void:
	super._ready()
	monitor_3d.monitor_control.exited.connect(exit_from_device)

func start_interaction(target: PlayerBody3D) -> void:
	super.start_interaction(target)
	monitor_3d.power_on()
	computer_canvas.show()

func stop_interaction(target: PlayerBody3D) -> void:
	super.stop_interaction(target)
	monitor_3d.power_off()
	computer_canvas.hide()
