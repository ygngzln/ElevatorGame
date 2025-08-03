extends Area2D

@export var next_scene_path: String = "res://scenes/levels/level_2.tscn"

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":  # Adjust to match your player node's name
		get_tree().change_scene_to_file(next_scene_path)
