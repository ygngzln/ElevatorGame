extends Node
class_name GameManager

@onready var projectilePool: Node = $"../".find_child("projectiles");
@onready var player:CharacterBody2D = $"../".find_child("Player");
@onready var regen:Timer = $"../".find_child("Regen");


var score := 0;
var regen_enabled := true

func _ready():
	regen.start();

func _updatescore(value):
	score += value

func spawnProjectile(node):
	projectilePool.add_child(node);

func _on_regen_timeout() -> void:
	if regen_enabled:
			Global.change_stat(5.0, 100.0, "health");
			Global.change_stat(15.0, 100.0, "mana");
