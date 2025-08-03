extends RichTextLabel

@onready var textBox = get_node("../Health")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_health_changed.connect(changeValue)
	pass # Replace with function body.


func changeValue(new_value, _change = 0):
	textBox.parse_bbcode(str(int(ceil(new_value))))
