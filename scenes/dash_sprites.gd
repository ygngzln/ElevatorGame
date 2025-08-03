extends AnimatedSprite2D

@export var fade_time := 0.3
var time_passed := 0.0

func _ready():
	modulate = Color(0.5, 0.8, 4.0)
	modulate.a = 0.9  # Start slightly transparent
	frame = 0;

func _process(delta):
	time_passed += delta
	var t = time_passed / fade_time
	modulate.a = lerp(0.8, 0.0, t)
	if t >= 1.0:
		queue_free()
