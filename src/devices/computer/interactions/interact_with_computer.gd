class_name InteractWithComputer
extends InteractWithDevice

signal report_completed(is_success: bool)

@export var monitor_3d: Monitor3D
@export var computer_canvas: CanvasLayer

func _ready() -> void:
    monitor_3d.monitor_control.exited.connect(exit_from_device)
    monitor_3d.monitor_control.report_completed.connect(report_completed.emit)

func start_interaction(target: PlayerBody3D) -> void:
    super.start_interaction(target)
    monitor_3d.power_on()
    computer_canvas.show()
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func stop_interaction() -> void:
    monitor_3d.power_off()
    computer_canvas.hide()
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    super.stop_interaction()
