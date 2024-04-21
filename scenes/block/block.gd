extends Area2D
class_name Block


@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var block_points: int = 1:
	set(value):
		block_points = value
		match block_points:
			1:
				modulate = Color("80ff74")
			2:
				modulate = Color("ffff27")
			3:
				modulate = Color("ff7027")
			4:
				modulate = Color("ff2c27")
				
static var amount_of_blocks: int = 0

func hit():
	var cond: bool = ray_cast_2d.is_colliding()
	amount_of_blocks += -1
	queue_free()
	return  cond

func _ready() -> void:
	amount_of_blocks += 1
