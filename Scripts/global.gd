extends Node
signal player_health_changed(new_health: float, change: float)
signal player_mana_changed(new_mana: float, change: float)
var player;
var stats := {
	"health": 100.0,
	"mana": 100.0
}

func reload_scene():
	Engine.time_scale = 1;
	get_tree().reload_current_scene();
	initializePlayer();

func change_stat(change, cap, key):
	
	if player.invul.active == true:
		return;
		
	stats[key] += change;
	#Caps the stat between 0 and 100 (can 
	#be changed for other values later)
	if stats[key] >= cap: stats[key] = cap;
	if stats[key] <= 0: stats[key] = 0;
	
	var signalString = "player_" + key + "_changed";
	emit_signal(signalString, stats[key], change);

func _init():
	initializePlayer();

func initializePlayer():
	stats["health"] = 100;
	stats["mana"] = 100;
	
# Custom Functions	

func await_physics_frames(count: int) -> void:
	for i in count:
		await get_tree().physics_frame
