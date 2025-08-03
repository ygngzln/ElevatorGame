extends CharacterBody2D

var playerMovingIn = false;
var mvmt:float;
var time = 80;

var next_scene_path: String = "res://scenes/levels/level_4.tscn"

func _ready():
	$Sprites.animation = "default";

func _on_check_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.player.stopMoving();
		$DashCharge.emitting = true;
		$SmokeTimer.start();
		Global.player.global_position.y = global_position.y+16
		Global.player.global_position.x = global_position.x-6

func _on_smoke_timer_timeout() -> void:
	$DashCharge.emitting = false;
	await get_tree().create_timer(0.2).timeout
	$Sprites.play("default");
	await $Sprites.animation_finished;
	Global.player.animated_sprite.play("walk");
	playerMovingIn = true;
	mvmt = abs(global_position.x + 4 - Global.player.global_position.x)/80.0;
	time = 80.0;

func _physics_process(delta: float) -> void:
	if playerMovingIn:
		time -= 1;
		Global.player.global_position.x += mvmt;
		if time <= 0:
			playerMovingIn = false;
			Global.player.animated_sprite.play("idle");
			Global.player.animated_sprite.stop();
			await get_tree().create_timer(0.35).timeout
			$Sprites.play("close");
			Global.player.visible = false;
			await $Sprites.animation_finished;
			get_tree().change_scene_to_file(next_scene_path)
