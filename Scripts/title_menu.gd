extends Control

func button_down() -> void:
	$Transitions.control("vanishSlider", "open");
	await $Transitions.end;
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn");
