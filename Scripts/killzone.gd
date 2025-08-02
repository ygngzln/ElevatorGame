extends Area2D

@onready var timer: Timer = $Timer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var gm:Node = get_tree().root.get_child(2).get_node("gamemanager");

@export var damage:float = 100.0;
@export var hurtDelay:float = 0.5;

func _ready():
	$Timer.wait_time = hurtDelay;

func _on_body_entered(body: Node2D) -> void:
	#audio.play()
	if body.name == "Player":
		_on_timer_timeout();
		timer.start();
	else:
		body.queue_free();

func _on_timer_timeout() -> void:
	Global.change_stat(-damage, 100.0, "health");

func _on_body_exited(_body: Node2D) -> void:
	timer.stop();
