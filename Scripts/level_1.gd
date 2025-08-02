extends Node2D

@onready var audio: AudioStreamPlayer = $gamefinished/AudioStreamPlayer

func _on_restartbutton_pressed() -> void:
	#get_tree().reload_current_scene()
	pass;

func _on_gamefinished_body_entered(body: Node2D) -> void:
	#audio.play()
	pass;
