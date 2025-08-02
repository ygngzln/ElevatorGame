extends Node
signal player_health_changed(new_health: float)
signal player_mana_changed(new_mana: float)

var stats := {
	"health": 100.0,
	"mana": 100.0
}

func reload_scene_after_animation(animated_sprite: AnimatedSprite2D):
	await animated_sprite.animation_finished;
	Engine.time_scale = 1;
	get_tree().reload_current_scene();

func reload_scene_after_delay(seconds: float):
	await get_tree().create_timer(seconds).timeout;
	get_tree().reload_current_scene();
	initializePlayer();

func change_stat(change, cap, key):
	stats[key] += change;
	#Caps the stat between 0 and 100 (can 
	#be changed for other values later)
	if stats[key] >= cap: stats[key] = cap;
	if stats[key] <= 0: stats[key] = 0;
	
	var signalString = "player_" + key + "_changed";
	emit_signal(signalString, stats[key]);

func _init():
	initializePlayer();

func initializePlayer():
	stats["health"] = 100;
	stats["mana"] = 100;
