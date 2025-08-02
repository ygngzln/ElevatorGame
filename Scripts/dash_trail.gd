extends Line2D

var is_dashing := false
var fading = false;
var maxpts = 10;
@onready var target = get_parent();
var tracking = false;

func start_dash():
	modulate.a = 1.0
	show()
	clear_points()
	fading = false;
	tracking = true;

func end_dash():
	fading = true;
	tracking = false;

func _physics_process(delta):
	if tracking and target:
		add_point(target.global_position+Vector2(-4,2))
		while points.size() > maxpts:
			remove_point(0)
	elif fading:
		modulate.a = max(0.0, modulate.a - delta * 20)
		if modulate.a <= 0.0:
			clear_points()
			hide()
			fading = false
