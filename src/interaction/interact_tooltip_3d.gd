class_name InteractTooltip3D
extends Area3D

@export var interaction: InteractionArea3D

@onready var distance_tooltip: SmoothAppearSprite3D = $"Main Tooltip/SmoothAppearSprite3D"
@onready var key_tooltip: SmoothAppearSprite3D = $"Interact Tooltip/SmoothAppearSprite3D"
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var update_timer: Timer = $"Update Timer"

var is_player_inside: bool
var is_disabled: bool

var inside_player: PlayerBody3D

func _ready() -> void:
	enable()

func enable() -> void:
	is_disabled = false
	collision_shape_3d.disabled = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	interaction.hovered.connect(_on_hovered)
	interaction.unhovered.connect(_on_unhovered)
	update_timer.timeout.connect(_on_update_timeout)

func disable() -> void:
	is_disabled = true
	collision_shape_3d.disabled = true
	body_entered.disconnect(_on_body_entered)
	body_exited.disconnect(_on_body_exited)
	interaction.hovered.disconnect(_on_hovered)
	interaction.unhovered.disconnect(_on_unhovered)
	update_timer.timeout.disconnect(_on_update_timeout)
	
	if distance_tooltip.is_visible():
		distance_tooltip.smooth_hide()
	if key_tooltip.is_visible():
		key_tooltip.smooth_hide()

func _on_update_timeout() -> void:
	if key_tooltip.is_visible():
		return
	
	var is_interactable := interaction.can_interact_with(inside_player)
	
	if is_interactable and not distance_tooltip.is_visible():
		distance_tooltip.smooth_show()
	elif not is_interactable and distance_tooltip.is_visible():
		distance_tooltip.smooth_hide()

func _on_body_entered(player: PlayerBody3D) -> void:
	if interaction.can_interact_with(player):
		distance_tooltip.smooth_show()
	
	is_player_inside = true
	inside_player = player
	update_timer.start()

func _on_body_exited(player: PlayerBody3D) -> void:
	if interaction.can_interact_with(player):
		distance_tooltip.smooth_hide()
	
	is_player_inside = false
	inside_player = null
	update_timer.stop()

func _on_hovered() -> void:
	if distance_tooltip.is_visible():
		distance_tooltip.smooth_hide()
	key_tooltip.smooth_show()

func _on_unhovered() -> void:
	if is_player_inside:
		distance_tooltip.smooth_show()
	key_tooltip.smooth_hide()
