extends Enemy

@onready var ray_cast1: RayCast2D = $RayCast2D1
@onready var ray_cast2: RayCast2D = $RayCast2D2
@onready var ray_cast3: RayCast2D = $RayCast2D3
@onready var ray_cast4: RayCast2D = $RayCast2D4

var targeting = false
var originalpos
func _ready():
	originalpos = global_position
	SPEED = 100
	
var range = 100

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
	else:
		print("yee")
		velocity = (Global.player.global_position - global_position).normalized() * SPEED
		
		
	
	if is_on_floor() and not targeting:
		velocity.x = direction * SPEED
		animated_sprite_2d.play("run");
	#apply gravity
	elif not is_on_floor() and not targeting:
		velocity += get_gravity() * delta * 4;
	checkDir();
	move_and_slide()
	$AnimatedSprite2D2.global_position = originalpos
	$Line2D.clear_points()
	$Line2D.add_point(global_position)
	$Line2D.add_point(originalpos)
	staywithin()


func _on_targetzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		targeting = true


func _on_targetzone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		targeting = false


func staywithin() -> void:
	var targvec = global_position - originalpos
	if targvec.length() > range:
		global_position = originalpos + targvec.normalized() * range
