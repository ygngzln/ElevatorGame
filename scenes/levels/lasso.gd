extends Line2D

@export var player_node: NodePath = NodePath("../Player")
@export var static_point_position: Vector2 = Vector2(0, 0)

func _process(delta):
	var player = get_node(player_node)
	if not player:
		return

	# Convert global coordinates to local space of this Line2D
	var local_static = to_local(static_point_position)
	var local_dynamic = to_local(player.global_position)

	points = [local_static, local_dynamic]
	self.width = 9
