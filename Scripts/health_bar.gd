extends TextureProgressBar

func _ready():
	pass;

func change(x):
	value += x;
	return value > 0;

func newMax(x):
	max_value = x;
	value = x;
	
