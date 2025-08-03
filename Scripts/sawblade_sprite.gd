extends AnimatedSprite2D

var count = 0;

 
func _ready():
	$"../Timer".timeout.connect(_on_timer_timeout)
	if (frame >= 2):
		count += 1;

func change_sprite():
	if frame & 1:
		frame-=1;
		rotation_degrees += 180;
	else:
		frame+=1;
		rotation_degrees -= 180;
	
func _on_timer_timeout():
	if count == 0:
		count += 1;
	else:
		count = 0;
		change_sprite();	
