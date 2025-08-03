extends Enemy

@export var dir:Timer;

@onready var ray_cast1: RayCast2D = $RayCast2D1
@onready var ray_cast2: RayCast2D = $RayCast2D2

var tracking = false

func _ready():
	dir.start();

func _physics_process(delta: float) -> void:
	if kb.active:
		takeKB();
		return;
	elif not tracking:
		velocity.y = 0
	
	if not tracking:
		if ray_cast1.is_colliding():
			direction = -1;
		if ray_cast2.is_colliding():
			direction = 1;
		
		velocity.x = direction * SPEED;
		
	else:
		var targvec = (Global.player.global_position - global_position).normalized()
		velocity = targvec * SPEED
		
	
	checkDir();
	if (health > 0):
		move_and_slide()


func _on_direction_change_timeout() -> void:
	direction *= -1;

func _on_targetzone_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	tracking = true
	

func _on_targetzone_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	tracking = false
