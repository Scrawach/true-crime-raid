class_name InteractWithDNAAnalyzer
extends InteractWithDevice

@export var monitor: DNAMonitor3D
@export var tube_position: Marker3D

var tube_moving: Tween
var monitor_content: DNAMonitorControl

func start_interaction(target: PlayerBody3D) -> void:
	move_tube_to_position(target.hand.item)
	
	super.start_interaction(target)
	monitor.power_on()
	monitor_content = monitor.content as DNAMonitorControl
	monitor_content.initialize(get_dna_data_from_item(target.hand.item))
	monitor_content.power_on()

func stop_interaction(target: PlayerBody3D) -> void:
	super.stop_interaction(target)
	monitor.power_off()
	monitor_content.power_off()
	move_tube_to_player_hand(target.hand.item, target.hand)

func get_dna_data_from_item(item: BaseItem) -> DNAData:
	if item is DNAItem:
		return item.dna_data
	return DNAData.new()

func move_tube_to_position(tube: Node3D) -> void:
	_kill_moving_if_needed()
	tube_moving = create_tween()
	tube_moving.tween_property(tube, "global_position", tube_position.global_position + Vector3.UP * 0.2, 0.25)
	tube_moving.parallel().tween_property(tube, "global_rotation", tube_position.global_rotation, 0.25)
	tube_moving.tween_property(tube, "global_position", tube_position.global_position, 0.1)

func move_tube_to_player_hand(tube: Node3D, hand: PlayerHand) -> void:
	_kill_moving_if_needed()
	tube_moving = create_tween()
	tube_moving.tween_property(tube, "global_position", hand.hand_point.global_position, 0.2)
	tube_moving.parallel().tween_property(tube, "global_rotation", hand.hand_point.global_rotation, 0.25)

func _kill_moving_if_needed() -> void:
	if tube_moving:
		tube_moving.custom_step(9999)
		tube_moving.kill()
