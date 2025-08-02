extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node2D) -> void:	
	if body.name == "Player":
		$AnimatedSprite2D.visible = false;
		$AudioStreamPlayer.play();
		await $AudioStreamPlayer.finished;
		queue_free();
