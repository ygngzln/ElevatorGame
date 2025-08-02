extends CharacterBody2D
class_name Enemy;

@export var SPEED = 80.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast1: RayCast2D = $RayCast2D1
@onready var ray_cast2: RayCast2D = $RayCast2D2
@onready var ray_cast3: RayCast2D = $RayCast2D3
@onready var ray_cast4: RayCast2D = $RayCast2D4

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
		$AnimatedSprite2D.visible = false;
		$HealthBar.visible = false;
		$Health.visible = false;
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
