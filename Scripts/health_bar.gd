# PlayerHealthBar.gd (or whatever you name your progress bar script)
extends TextureProgressBar

@onready var tween:Tween;
@export var health:bool = true;
@export var mana:bool = false;
@export var enemy:bool = false;

func _ready():
	await get_tree().process_frame
	value = max_value;
	if health: Global.player_health_changed.connect(changeValue);
	if mana: Global.player_mana_changed.connect(changeValue);
	
func changeValue(new_value):
	if tween: tween.kill()
	tween = create_tween()
	tween.tween_property(self, "value", new_value, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
