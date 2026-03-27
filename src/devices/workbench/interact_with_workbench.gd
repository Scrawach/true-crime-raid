class_name InteractWithWorkbench
extends InteractWithDevice

var inspect_item: InspectItem

func start_interaction(target: PlayerBody3D) -> void:
	inspect_item = target.inspect_item
	super.start_interaction(target)
	inspect_item.smooth_show()

func stop_interaction() -> void:
	inspect_item.smooth_hide()
	super.stop_interaction()
