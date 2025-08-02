extends Enemy

@export var dir:Timer;

func _ready():
	dir.start();

func _physics_process(delta: float) -> void:
	if kb.active:
		takeKB();
		return;
	velocity.x = direction * SPEED;
	checkDir();
	move_and_slide()


func _on_direction_change_timeout() -> void:
	direction *= -1;
