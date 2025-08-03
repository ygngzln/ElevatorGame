extends Enemy

@onready var ray_cast1: RayCast2D = $RayCast2D1
@onready var ray_cast2: RayCast2D = $RayCast2D2
@onready var ray_cast3: RayCast2D = $RayCast2D3
@onready var ray_cast4: RayCast2D = $RayCast2D4

var launching = false;
var launchVector;

func _physics_process(delta: float) -> void:
	if kb.active:
		takeKB();
		return;
	#change direction according to which raycast is colliding
	if ray_cast1.is_colliding() or not ray_cast3.is_colliding():
		direction = -1;
	if ray_cast2.is_colliding() or not ray_cast4.is_colliding():
		direction = 1;
	#handling movement
	if is_on_floor() and health > 0:
		velocity.x = direction * SPEED
		animated_sprite_2d.play("run");
	#apply gravity
	else:
		if launching:
			velocity = launchVector;
		velocity += get_gravity() * delta * 4;
		launchVector = velocity;
	checkDir();
	if health > 0:
		move_and_slide()

func launch(x, y):
	launchVector = Vector2(x, y);
	launching = true;
