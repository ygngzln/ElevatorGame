extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


func _hurt_player(player) -> void:
	Global.change_stat(-50, 100, "health")

func retrigger(body) -> void:
	if not body.dead:
		$Area2D/CollisionShape2D.shape.radius = 1;
		$Area2D/CollisionShape2D.shape.height = 1;
	await get_tree().physics_frame;
	await get_tree().physics_frame;
	$Area2D/CollisionShape2D.shape.radius = 17;
	$Area2D/CollisionShape2D.shape.height = 48;
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_hurt_player(body);
		retrigger(body);
