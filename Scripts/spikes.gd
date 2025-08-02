extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpikeSprite.frame = randi_range(0, 1);

func _add_blood_to_spike() -> void:
	if $SpikeSprite.frame < 4:
		$SpikeSprite.frame += randi_range(1, 2);
	
func _hurt_player(player) -> void:
	Global.change_stat(-25, 100, "health")
	_add_blood_to_spike();

func retrigger(body) -> void:
	if not body.dead:
		$Area2D/SpikeHurtbox.shape.extents = Vector2(1, 1);
	await get_tree().physics_frame;
	await get_tree().physics_frame;
	$Area2D/SpikeHurtbox.shape.extents = Vector2(10, 6);
	body.spikes_active = true;
	
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" && body.spikes_active == true:
		_hurt_player(body);
		body.spikes_active = false;
		retrigger(body);
