extends CharacterBody2D

@export var SPEED:float = 120.0
@export var JUMP_VELOCITY:float = -375.0

@export var dashTrail:Line2D;
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var projectile := load("res://scenes/knife.tscn")

@onready var gameManager:Node = $"../".find_child("gamemanager");
@onready var mana_bar: TextureProgressBar = $"../".find_child("ManaBar")
#Invulnerability
var invul := {
	"active": false,
	"timer": 0,
	"time": 40
}

var coyote := {
	"active": false,
	"timer": 0,
	"time": 10
}


var shootAnim = false;
var timers = [invul, coyote];

var was_on_floor := true

var dashed = false
var dashing = false
var dashX = 500
var dashY = 300
var spikes_active = true;
var dead = false;

func _ready():
	Global.player_health_changed.connect(self._on_player_health_changed)
	Global.player = self;
	dead = false;

func _physics_process(delta: float) -> void:
	if !dead and Input.is_action_just_pressed("shoot") and Global.stats["mana"] >= 29 and !shootAnim:
		animated_sprite.play("shoot");
		shootAnim = true;
		await animated_sprite.animation_finished;
		shootAnim = false;
		if shoot():
			Global.change_stat(-34.5, 100.0, "mana");

	decreaseTimers()

	if not dashing:
		if Input.is_action_pressed("move_left"):
			velocity.x = -SPEED
			animated_sprite.flip_h = true
			animated_sprite.offset = Vector2(-20, 0)
		elif Input.is_action_pressed("move_right"):
			velocity.x = SPEED
			animated_sprite.flip_h = false
			animated_sprite.offset = Vector2(0, 0)
		else:
			velocity.x = 0

	if is_on_floor() and dashed and not dashing and $dashCooldown.is_stopped():
		dashed = false
	
	if Input.is_action_pressed("dash") and not dashed:
		
		Global.change_stat(-30, 100, "mana");
		dashed = true
		dashing = true
		dashTrail.start_dash();

		# Dash in the direction the sprite is facing
		velocity.x = -dashX if animated_sprite.flip_h else dashX

		# Optional vertical dash modifiers
		if Input.is_action_pressed("jump"):
			velocity.y = -dashY
		elif Input.is_action_pressed("crouch"):
			velocity.y = dashY
		$dashTimer.start()	
		
		invul.active = true;
		invul.timer = invul.time;
		
	if (is_on_floor() or coyote.active) and Input.is_action_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		coyote.active = false
	elif is_on_floor():
		coyote.active = true
		coyote.timer = coyote.time
	elif not dashing:
		velocity += get_gravity() * delta

	var animCheckFloor := was_on_floor;
	# Update was_on_floor state
	was_on_floor = is_on_floor()

	move_and_slide()
	if shootAnim or dead: return;
	if is_on_floor():
		if velocity == Vector2.ZERO:
			animated_sprite.play("idle");
			return;
		animated_sprite.play("walk");
		return;
	if animCheckFloor:
		animated_sprite.play("jump")

func decreaseTimers():
	for i in timers:
		if i.active:
			i.timer -= 1;
			if i.timer <= 0:
				i.active = false;

func shoot():
	var direction_vector = get_global_mouse_position() - global_position
	var angle_radians = direction_vector.angle()

	var facing_left = animated_sprite.flip_h
	var is_mouse_on_correct_side = (
		(not facing_left and direction_vector.x >= 0) or
		(facing_left and direction_vector.x <= 0)
	)

	if not is_mouse_on_correct_side:
		return false;

	var offset_distance = 5
	var offset = Vector2(offset_distance, 0)
	if facing_left:
		offset.x *= -1

	var spawn_position = global_position + offset

	var instance = projectile.instantiate()
	instance.dir = angle_radians
	instance.spawnPos = spawn_position
	instance.spawnRot = angle_radians
	instance.player = self

	get_tree().get_current_scene().add_child(instance)
	return true;

func _on_dash_timer_timeout() -> void:
	velocity.x = 0
	invul.timer = 5;
	dashTrail.end_dash();
	dashing = false
	$dashCooldown.start()

func _on_dash_cooldown_timeout() -> void:
	print("hi")

func _on_player_hurt():
	invul.active = true;
	invul.timer = invul.time;
	await Global.await_physics_frames(2)
	$AnimatedSprite2D.modulate = Color(1, 0, 0)  # Red
	$PlayerHurt.play();
	await Global.await_physics_frames(10)
	$AnimatedSprite2D.modulate = Color(1, 1, 1)  # Back to normal 

func _on_player_health_changed(new_health: float, change: float):	
	if new_health <= 0:
		handle_player_death()
		return;
	if change < 0:
		if invul.active == true:
			return;
		else:
			_on_player_hurt();
			

func handle_player_death():
	if dead: return;
	dead = true;
	Engine.time_scale = 0.5;
	await get_tree().create_timer(0.14).timeout;
	animated_sprite.play("death")
	await animated_sprite.animation_finished;
	Global.reload_scene();
	queue_free()
