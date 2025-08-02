extends ColorRect
signal end;

var transitioning:bool = false;
@onready var shader:ShaderMaterial = self.material;
var time:float = 0.0;
@export var speed:float = 0.003;
@export var maxTime:float = 1.0;
@export var endDelay:float = 0.01;

func _ready():
	pass;

func setup(settings):
	shader.set_shader_parameter("direction", true);
	time = 0.0;
	if settings == "open":
		speed *= -1;
		time = min(maxTime, 1.0);
		shader.set_shader_parameter("direction", false);

func start(settings):
	setup(settings);
	transitioning = true;

func _physics_process(delta: float) -> void:
	if transitioning:
		time += speed;
		shader.set_shader_parameter("time", clamp(time, 0, 1));
		if time < -endDelay or time > maxTime+endDelay:
			transitioning = false;
			speed = abs(speed);
			end.emit();
