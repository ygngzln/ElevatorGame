extends Enemy

@onready var ray_cast1: RayCast2D = $RayCast2D1
@onready var ray_cast2: RayCast2D = $RayCast2D2
@onready var ray_cast3: RayCast2D = $RayCast2D3
@onready var ray_cast4: RayCast2D = $RayCast2D4

var canthrow = true
var targeting = false
var projectile

func _ready():
	projectile = preload("res://scenes/orb.tscn")

func _physics_process(delta: float) -> void:
	if kb.active:
		takeKB();
		return;
	#change direction according to which raycast is colliding
	if not targeting:
		if ray_cast1.is_colliding() or not ray_cast3.is_colliding():
			direction = -1;
		if ray_cast2.is_colliding() or not ray_cast4.is_colliding():
			direction = 1;
	elif canthrow:
		var direction_vector = (Global.player.global_position - global_position).normalized()
		var angle_radians = direction_vector.angle()

		var spawn_position = global_position

		var instance = projectile.instantiate()
		get_tree().current_scene.add_child(instance)
		
		instance.dir = angle_radians
		
		#instance.spawnPos = spawn_position
		instance.global_position = global_position
		instance.spawnRot = angle_radians
		instance.thrower = self
		canthrow = false
		$throwreload.start()
	else:
		velocity.x = 0
		
	
	if is_on_floor() and not targeting:
		velocity.x = direction * SPEED
		animated_sprite_2d.play("run");
	#apply gravity
	else:
		velocity += get_gravity() * delta * 4;
	checkDir();
	move_and_slide()



func _on_throwreload_timeout() -> void:
	canthrow = true


func _on_targetzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		targeting = true


func _on_targetzone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		targeting = false
