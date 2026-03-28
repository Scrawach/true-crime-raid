class_name AwaitAnyOf
extends RefCounted

signal finished

var signals: Array[Signal]

func _init(awaiting_signals: Array[Signal]) -> void:
	signals = awaiting_signals
	for s in signals:
		s.connect(_on_finished)

func _on_finished(item) -> void:
	finished.emit()

func clear() -> void:
	for s in signals:
		s.disconnect(_on_finished)
