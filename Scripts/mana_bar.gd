# PlayerHealthBar.gd (or whatever you name your progress bar script)
extends TextureProgressBar

@onready var tween := create_tween()

func _ready():
	await get_tree().process_frame  # Let Global._ready() run first
	print("✅ PlayerManaBar ready")
	print("✅ Global mana is", Global.player_mana)
	value = Global.player_mana
	Global.player_mana_changed.connect(_on_player_mana_changed)

# --- Signal Handler Function ---

func _on_player_mana_changed(new_mana: float):
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, "value", new_mana, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
