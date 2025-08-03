extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_door():
	$AnimatedSprite2D.frame = 1;
	$Hitbox.call_deferred("set_disabled", true)
	
func close_door():
	$AnimatedSprite2D.frame = 0;
	$Hitbox.call_deferred("set_disabled", false)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		open_door();

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		close_door();
