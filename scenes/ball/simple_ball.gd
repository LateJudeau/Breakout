extends Area2D
class_name Ball

@onready var audio_player: Audio = get_tree().get_first_node_in_group("audio_player")
@onready var arena: Arena = get_tree().get_first_node_in_group("arena")
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@export var max_angle: float = 0.5
var speed: int = 400:
	set(value):
		match value:
			1: 
				speed = 600
			2:
				speed = 800
			3:
				speed = 1000
			4:
				speed = 1200
			_: 
				speed = 400
		
var velocity_vector: Vector2 = Vector2.UP:
	set(value):
		velocity_vector = value.normalized()


#func _process(delta: float) -> void:
	#global_position = get_global_mouse_position()
@onready var follower: Follower = get_tree().get_first_node_in_group("ball_follower")

func _exit_tree() -> void:
	audio_player.play_ball_out()


func _physics_process(delta: float) -> void:
	global_position += velocity_vector*speed*delta
	ray_cast_2d.target_position = velocity_vector * speed * 2
	follower.global_position = global_position/2
	#global_position = get_global_mouse_position()

func _ready() -> void:
	follower.follower_color = 1
	audio_player.play_new_ball()

func top_wall_hit():
	audio_player.play_wall_hit()
	velocity_vector *= Vector2(1, -1)

func side_wall_hit():
	audio_player.play_wall_hit()
	velocity_vector *= Vector2(-1, 1)
	

func paddle_hit(body: Node2D):
	audio_player.play_paddle_hit()
	#var angle = get_angle_to(body.global_position)
	var angle = body.global_position.x - global_position.x
	angle = remap(angle,0,30,0,0.5)
	velocity_vector *= Vector2(1,-1)
	velocity_vector += Vector2(angle*-1,0)
	velocity_vector.x = clampf(velocity_vector.x,-0.6, 0.6)

	
func block_hit(area: Area2D):
	audio_player.play_block_hit()
	var offset: Vector2 = area.global_position - global_position
	if area.hit():
		velocity_vector *= Vector2(-1, 1)
		#elif offset.x > 11 or offset.x < -11:
	elif offset.y > 2 or offset.y < -2:
		velocity_vector *= Vector2(1, -1)
	follower.follower_color = area.block_points
	speed = area.block_points
	arena.player_points += area.block_points


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("block"):
		block_hit(area)
	elif area.is_in_group("paddle"):
		paddle_hit(area)
	elif area.is_in_group("side_wall"):
		side_wall_hit()
	elif area.is_in_group("top_wall"):
		top_wall_hit()
