extends Control;
signal end;

var transitioning:bool = false;
var idx = 0;

@onready var anims = {
	"eyes": $Eyes,
	"vanishSlider": $VanishSlider
}

func _ready():
	#able(false)
	for str in anims:
		anims[str].end.connect(endTransition);

func able(v):
	transitioning = v;
	visible = v;

func disableAll():
	for str in anims:
		anims[str].visible = false;

func enable(str):
	anims[str].visible = true;

func control(anim, settings):
	print(settings);
	able(true);
	disableAll();
	enable(anim);
	anims[anim].start(settings);

func endTransition():
	able(false);
	end.emit(idx);
