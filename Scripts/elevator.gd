extends CharacterBody2D

var playerMovingIn = false;
var mvmt:float;
var time = 80;

func _on_check_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.player.stopMoving();
		$DashCharge.emitting = true;
		$SmokeTimer.start();

func _on_smoke_timer_timeout() -> void:
	$DashCharge.emitting = false;
	await get_tree().create_timer(0.2).timeout
	print("??")
	$Sprites.play("default");
	await $Sprites.animation_finished;
	Global.player.position = Vector2(1105, 32);
	playerMovingIn = true;
	mvmt = abs(global_position.x + 2 - Global.player.global_position.x)/80.0;
	time = 80.0;

func _physics_process(delta: float) -> void:
	if playerMovingIn:
		time -= 1;
		Global.player.global_position.x += mvmt;
		if time <= 0:
			playerMovingIn = false;
	#Global.endGame();
