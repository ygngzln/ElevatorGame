extends Node

func reload_scene_after_animation(animated_sprite: AnimatedSprite2D):
	await animated_sprite.animation_finished
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func reload_scene_after_delay(seconds: float):
	await get_tree().create_timer(seconds).timeout
	get_tree().reload_current_scene()
	player_health = 100
	player_mana = 100
	
signal player_health_changed(new_health: float)

var _player_health = 100.0

# Property for player_health with a setter that emits the signal
func set_player_health(new_health: float):
	# Only emit if the value actually changed
	if _player_health != new_health:
		_player_health = new_health
		emit_signal("player_health_changed", _player_health)

var player_health: float:
	set(value):
		set_player_health(value)
	get:
		return _player_health

signal player_mana_changed(new_health: float)

var _player_mana = 100.0

# Property for player_health with a setter that emits the signal
func set_player_mana(new_mana: float):
	# Only emit if the value actually changed
	if _player_mana != new_mana:
		_player_mana = new_mana
		emit_signal("player_mana_changed", _player_mana)

# Using 'player_health' as a public-facing property that uses the custom setter
# and the default getter
var player_mana: float:
	set(value):
		set_player_mana(value)
	get:
		return _player_mana
	
func _init():
	player_health = 100.0 # Set initial player health
	player_mana = 100.0

func _ready():
	start_regeneration() 

var regen_enabled := true

func start_regeneration():
	while true:
		await get_tree().create_timer(1.0).timeout
		if regen_enabled:
			player_health = min(player_health + 5.0, 100.0)
			player_mana = min(player_mana + 15.0, 100.0)
			
