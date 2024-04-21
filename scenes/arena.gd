extends Node2D
class_name Arena



@export var levels: Levels


@onready var lives_label: Label = %LivesLabel
@onready var points_label: Label = %PointsLabel
@onready var arena_width: float = $"Walls/Wall".global_position.x
@onready var ball_spawn_vector: RayCast2D = $BallSpawnVector
@onready var block_lines: Node2D = $BlockLines
const SIMPLE_BALL = preload("res://scenes/ball/simple_ball.tscn")
const BLOCK_LINE = preload("res://scenes/block/block_line.tscn")
var BLOCK = preload("res://scenes/block/block.tscn").instantiate()
var block_amount: int = 16
var player_lives: int = 3:
	set(value):
		player_lives = value
		lives_label.text = str(player_lives)
		
var player_points: int = 0:
	set(value):
		player_points = value
		points_label.text = str(player_points)
		if BLOCK.amount_of_blocks < 1:
			print("LEVEL WON! WOO! BABAY!")


func _ready() -> void:
	inizialize_level()
	spawn_ball()

	
func inizialize_level():
	var line_position: int = 0
	var this_level = levels.get_next_level()
	for i in range(len(this_level.block_lines)):
		var new_line = BLOCK_LINE.instantiate()
		block_lines.add_child(new_line)
		new_line.position.y = line_position
		new_line.add_blocks(block_amount, this_level.block_lines[i])
		line_position += 21

		
	
func spawn_ball():
	var ball: Ball = SIMPLE_BALL.instantiate()
	add_child(ball)
	ball.global_position = ball_spawn_vector.global_position
	ball.velocity_vector = ball_spawn_vector.target_position
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("debug"):
		print(BLOCK.amount_of_blocks)
		spawn_ball()




func _on_arena_area_exited(ball: Ball) -> void:
	ball.queue_free()
	player_lives += -1
	await get_tree().create_timer(1).timeout
	spawn_ball()
