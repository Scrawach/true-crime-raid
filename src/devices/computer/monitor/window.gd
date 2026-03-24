extends Window



func _on_focus_entered() -> void:
	print("FOCUS: %s" % name)


func _on_focus_exited() -> void:
	print("unFOCUS: %s" % name)
