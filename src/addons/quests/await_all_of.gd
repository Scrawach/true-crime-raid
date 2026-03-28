class_name AwaitAllOf
extends RefCounted

signal finished

var signals: Array[Signal]
var finished_signals: Dictionary[Signal, int]

func _init(awaiting_signals: Array[Signal]) -> void:
	signals = awaiting_signals
	for s in signals:
		s.connect(_on_finished.bind(s))

func _on_finished(item, target_signal: Signal) -> void:
	finished_signals[target_signal] = 0 
	
	if finished_signals.size() >= signals.size():
		finished.emit()

func clear() -> void:
	for s in signals:
		s.disconnect(_on_finished)
