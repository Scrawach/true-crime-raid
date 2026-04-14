class_name TableStickers
extends Node3D

@export var connection_material: Material
@export var connection_thickness: float = 0.004

@export var add_player: AudioStreamPlayer

var stickers: Dictionary[String, Sticker]
var connections: Array[Connection]

func append(sticker: Sticker) -> void:
	if sticker.get_parent():
		sticker.reparent(self)
	else:
		add_child(sticker)
	
	if sticker.data:
		stickers[sticker.data.id] = sticker
	
	sticker.pin()
	create_connections(sticker)
	add_player.play()

func remove(sticker: Sticker) -> void:
	sticker.unpin()
	
	if sticker.data:
		stickers.erase(sticker.data.id)
	
	var sticker_connections := find_all_connections(sticker)
	for connection in sticker_connections:
		connection.mesh.queue_free()
		connections.erase(connection)
	add_player.play()

func has(sticker: Sticker) -> bool:
	return sticker in get_appended_stickers()

func get_appended_stickers() -> Array[Sticker]:
	var result: Array[Sticker]
	for child in get_children():
		if child is Sticker:
			result.append(child)
	return result

func create_connections(sticker: Sticker) -> void:
	if not sticker.data:
		return
	
	for connection in sticker.data.connections:
		if not stickers.has(connection):
			continue
		
		var target := stickers[connection]
		var line := Draw3D.line(sticker.pin_node.global_position, target.pin_node.global_position, self, connection_material, connection_thickness)
		connections.append(Connection.new(sticker, target, line))

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
