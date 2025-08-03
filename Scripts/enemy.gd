extends CharacterBody2D
class_name Enemy;

@export var SPEED = 80.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var health = 100;

var direction = 1

var kb = {
	"active": false,
	"vect": Vector2.ZERO,
	"time": 16
}

func takeKB():
	velocity += kb.vect.normalized() * 5;
	move_and_slide();
	
	if kb.time > 0:
		kb.time -= 1;
	else:
		kb.active = false;
		kb.vect = Vector2.ZERO;
		kb.time = 14;

func _physics_process(delta: float) -> void:
	if kb.active:
		takeKB();
		return;
	
	checkDir();

func checkDir():
	if direction == 1:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func damage(x, veloc):
	health -= 50;
	if health <= 0:
		print ("dead")
		$HealthBar.visible = false;
		$Health.visible = false;
		animated_sprite_2d.play("death")
		await animated_sprite_2d.animation_finished;
		animated_sprite_2d.visible = false;
		$Death.emitting = true;		
		await $Death.finished;
		queue_free();
	$HealthBar.changeValue(health)
	$Health.text = "[center]" + str(health)
	$Hit.emitting = true;
	if kb.active: return;
	kb.vect = veloc;
	kb.active = true;
	kb.time = 12;

func flipDir():
	direction *= -1;
