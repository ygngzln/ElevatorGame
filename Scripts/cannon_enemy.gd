extends Enemy

var projectile

func _ready():
	projectile = preload("res://scenes/land_enemy.tscn")
	
var tracking := false
var reloaded = true

var lobtime := 2
var launchX = 0
var launchY = 0


func _physics_process(delta: float) -> void:
	if tracking and reloaded:
		var targvec = Global.player.global_position - global_position
		var ydisp = targvec.y
		var xdisp = targvec.x
		launchX = xdisp/lobtime
		launchY = (ydisp-0.5*get_gravity().y*lobtime*lobtime)/lobtime
		var newspawn = projectile.instantiate()
		newspawn.global_position = self.get_parent().global_position
		newspawn.velocity.x = launchX*10
		newspawn.velocity.y = launchY
		add_child(newspawn)
		reloaded = false
		$cannonReload.start()
		print("pew")
	
	checkDir();
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

func _on_cannon_reload_timeout() -> void:
	reloaded = true
