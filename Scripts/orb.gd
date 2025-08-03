extends CharacterBody2D

@export var SPEED = 300

var dir: float
#var spawnPos: Vector2
var spawnRot: float

var alive_time := 0.0
const MAX_LIFETIME := 10.0
const MAX_DISTANCE := 1000.0

var thrower  # Set when the knife is spawned

func _ready() -> void:
	#pass
	#spawnPos = Global.player.global_position
	#self.global_position = spawnPos
	rotation = spawnRot
	print("Rotation applied:", rotation)


func _physics_process(delta: float) -> void:
	#pass
	# Move forward
	velocity = Vector2.RIGHT.rotated(dir) * SPEED
	move_and_slide()
	if get_slide_collision_count() > 0: queue_free();
	
	# Track time
	alive_time += delta
	if alive_time >= MAX_LIFETIME:
		queue_free();
		return;

	# Check distance to player
	if thrower and global_position.distance_to(thrower.global_position) >= MAX_DISTANCE:
		queue_free()

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#body.damage(35, velocity);
	#queue_free();
