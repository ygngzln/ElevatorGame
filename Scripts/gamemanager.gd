extends Node
class_name GameManager

@onready var projectilePool: Node = $"../".find_child("projectiles");
@onready var player:CharacterBody2D = $"../".find_child("Player");

var score := 0;

func _updatescore(value):
	score += value

func spawnProjectile(node):
	projectilePool.add_child(node);

func death():
	if Global.dead: return;
	Global.dead = true;
	Engine.time_scale = 0.5;
	await get_tree().create_timer(0.14).timeout;
	player.die();
	print("Step 4: wait for anim finish")
	print("Step 5: restoring time scale")
	Global.reload_scene_after_animation(player.animated_sprite)
