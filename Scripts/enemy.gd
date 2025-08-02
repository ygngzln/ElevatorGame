extends CharacterBody2D

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

func _physics_process(delta: float) -> void:
	if kb.active:
		velocity += kb.vect.normalized() * 260;
		move_and_slide();
		
		if kb.time > 0:
			kb.time -= 1;
		else:
			kb.active = false;
			kb.vect = Vector2.ZERO;
			kb.time = 14;
	velocity = Vector2.ZERO;
	#change direction according to which raycast is colliding
	if ray_cast1.is_colliding() or not ray_cast3.is_colliding():
		direction = -1;
	if ray_cast2.is_colliding() or not ray_cast4.is_colliding():
		direction = 1;
	#handling movement 
	if is_on_floor():
		velocity.x = direction * SPEED
		animated_sprite_2d.play("run");
	#apply gravity
	else:
		velocity += get_gravity() * delta
	#flipping the sprite according to direction
	if direction == 1:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	move_and_slide()

func damage(x, veloc):
	health -= 50;
	if health <= 0:
		$AnimatedSprite2D.visible = false;
		$Death.emitting = true;
		await $Death.finished;
		queue_free();
	$HealthBar.changeValue(health)
	if kb.active: return;
	kb.vect = veloc;
	kb.active = true;
	kb.time = 16;
