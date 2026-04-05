class_name TableStickers
extends Node3D

var connections: Array[Connection]

func append(sticker: Sticker) -> void:
	if sticker.get_parent():
		sticker.reparent(self)
	else:
		add_child(sticker)
		
	sticker.pin()
	create_connections_between()

func remove(sticker: Sticker) -> void:
	sticker.unpin()
	
	var sticker_connections := find_all_connections(sticker)
	for connection in sticker_connections:
		connection.mesh.queue_free()
		connections.erase(connection)

func has(sticker: Sticker) -> bool:
	return sticker in get_appended_stickers()

func get_appended_stickers() -> Array[Sticker]:
	var result: Array[Sticker]
	for child in get_children():
		if child is Sticker:
			result.append(child)
	return result

func create_connections_between() -> void:
	var stickers := get_appended_stickers()
	for sticker in stickers:
		for target_sticker in stickers:
			if sticker == target_sticker:
				continue
			
			var start_pos := target_sticker.pin_node.global_position
			var end_pos := sticker.pin_node.global_position
			var connection = Draw3D.line(start_pos, end_pos, Color.FIREBRICK, self, 0.005)
			connections.append(Connection.new(target_sticker, sticker, connection))

func has_connection_between(a: Sticker, b: Sticker) -> bool:
	for connection in connections:
		if connection.is_between(a, b):
			return true
	return false

func find_connection_between(a: Sticker, b: Sticker) -> Connection:
	for connection in connections:
		if connection.is_between(a, b):
			return connection
	return null

func find_all_connections(target: Sticker) -> Array[Connection]:
	var result: Array[Connection]
	for connection in connections:
		if connection.from == target or connection.to == target:
			result.append(connection)
	return result

class Connection extends RefCounted:
	var from: Sticker
	var to: Sticker
	var mesh: MeshInstance3D
	
	func _init(from_sticker: Sticker, to_sticker: Sticker, connection_mesh: MeshInstance3D) -> void:
		from = from_sticker
		to = to_sticker
		mesh = connection_mesh
	
	func is_between(a: Sticker, b: Sticker) -> bool:
		if from == a and to == b:
			return true
		if from == b and to == a:
			return true
		return false
