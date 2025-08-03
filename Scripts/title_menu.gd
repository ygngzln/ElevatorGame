extends Control

func _ready():
	print(get_tree())
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicked on this Control node!")
		# Do stuff here
		# Optionally consume the event:
		start_transition()
		
func start_transition() -> void:
	$Transitions.control("vanishSlider", "open")
	await $Transitions.end
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
