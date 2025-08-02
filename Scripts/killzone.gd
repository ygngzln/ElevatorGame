extends Area2D

@onready var timer: Timer = $Timer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var gm:Node = get_tree().root.get_child(2).get_node("gamemanager");
@onready var health: TextureProgressBar = get_tree().root.get_child(2).get_node("HUD/Parent/HealthBar");
@export var damage:float = 100.0;
@export var hurtDelay:float = 0.5;

func _ready():
	$Timer.wait_time = hurtDelay;

func _on_body_entered(body: Node2D) -> void:
	#audio.play()
	_on_timer_timeout();
	timer.start();

func _on_timer_timeout() -> void:
	if !health.change(-damage):
		timer.stop();
		print("I CALLED THIS")
		gm.death();

func _on_body_exited(body: Node2D) -> void:
	timer.stop();
