extends Enemy

var projectile

func _ready():
	projectile = preload("res://scenes/land_enemy.tscn")
	
var tracking := false
var reloaded = true

var lobtime := 2.0
var launchX := 0.0;
var launchY := 0.0;

var launched := 0.0;

func _physics_process(delta: float) -> void:
	if tracking and reloaded and launched < 1 and health > 0:
		var launch = calculate_arc_velocity(global_position, Global.player.global_position, -30, get_gravity().y)
		launchX = launch.x
		launchY = launch.y
		var newspawn = projectile.instantiate()
		get_parent().add_child(newspawn)
		newspawn.global_position = global_position
		newspawn.launch(launchX, launchY);
		reloaded = false
		launched += 1
		$cannonReload.start()
	
	checkDir();
	
	if (health > 0):
		move_and_slide()

func calculate_arc_velocity(source_position, target_position, arc_height, gravity):
	var velocity = Vector2();
	var displacement = target_position - source_position;
	if displacement.y < arc_height:
		arc_height = displacement.y;
	var time_up = sqrt(-2 * arc_height / float(gravity))
	var time_down = sqrt(2 * (displacement.y - arc_height) / float(gravity))

	velocity.y = -sqrt(-2 * gravity * arc_height)*1.5;
	velocity.x = displacement.x / float(time_up + time_down) 
	return velocity

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

func _on_cannon_reload_timeout() -> void:
	reloaded = true
