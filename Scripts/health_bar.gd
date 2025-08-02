# PlayerHealthBar.gd (or whatever you name your progress bar script)
extends TextureProgressBar

@onready var tween := create_tween()


func _ready():
	await get_tree().process_frame  # Let Global._ready() run first
	print("✅ PlayerHealthBar ready")
	print("✅ Global health is", Global.player_health)
	value = Global.player_health
	Global.player_health_changed.connect(_on_player_health_changed)

# --- Signal Handler Function ---

func _on_player_health_changed(new_health: float):
	tween.kill()  # cancel any existing tween
	tween = create_tween()
	tween.tween_property(self, "value", new_health, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
