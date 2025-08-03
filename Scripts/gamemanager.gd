extends Node
class_name GameManager

@onready var projectilePool: Node = $"../".find_child("projectiles");
@onready var player:CharacterBody2D = $"../".find_child("Player");
@onready var regen:Timer = $"../".find_child("Regen");


var score := 0;
var regen_enabled := true

func _ready():
	await get_tree().process_frame  # wait one frame
	regen = get_tree().current_scene.find_child("Regen", true, false)
	if regen:
		regen.start()
	else:
		push_error("Regen Timer not found!")

func _updatescore(value):
	score += value

func spawnProjectile(node):
	projectilePool.add_child(node);

func _on_regen_timeout() -> void:
	if regen_enabled:
		if Global.stats.health > 0:
			Global.change_stat(10.0, 100.0, "health");
		Global.change_stat(15.0, 100.0, "mana");
