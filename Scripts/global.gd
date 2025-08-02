extends Node

var dead = false;

func reload_scene_after_animation(animated_sprite: AnimatedSprite2D):
	await animated_sprite.animation_finished
	Engine.time_scale = 1
	get_tree().reload_current_scene()
