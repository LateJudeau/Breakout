extends Node2D
class_name Arena

var player_name: String = "Write your name"
@onready var score_menu: ScoreMenu = %ScoreMenu
var score_sheet: ScoreSheet = preload("res://custom_resources/score_sheet.gd").new()
@export var levels: Levels
@onready var submit_score_container: HBoxContainer = $CanvasLayer/SubmitScoreContainer
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var points_label: Label = %PointsLabel
@onready var arena_width: float = $"Walls/Wall".global_position.x
@onready var ball_spawn_vector: RayCast2D = $BallSpawnVector
@onready var block_lines: Node2D = $BlockLines
@onready var lives_indicator: LivesIndicator = %LivesIndicator
const SIMPLE_BALL = preload("res://scenes/ball/simple_ball.tscn")
const BLOCK_LINE = preload("res://scenes/block/block_line.tscn")
var BLOCK = preload("res://scenes/block/block.tscn").instantiate()
var block_amount: int = 16
var player_lives: int = 2:
	set(value):
		player_lives = value
		lives_indicator.update_lives(player_lives)
		
		
var player_points: int = 0:
	set(value):
		player_points = value
		points_label.text = str(player_points)
		if BLOCK.amount_of_blocks < 1:
			await get_tree().create_timer(1).timeout
			inizialize_level()



func _ready() -> void:
	score_sheet.load_scores()
	score_menu.add_scores(score_sheet)
	inizialize_level()
	spawn_ball()
	lives_indicator.update_lives(player_lives)


	
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
	
	await get_tree().create_timer(1).timeout
	add_child(ball)
	ball.global_position = ball_spawn_vector.global_position
	ball.velocity_vector = ball_spawn_vector.target_position
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("debug"):
		#print(BLOCK.amount_of_blocks)
		#score_sheet.scores_array = []
		#score_sheet.save_scores()
		spawn_ball()
	if event.is_action_pressed("ESCAPE"):
		var state: bool = get_tree().paused
		get_tree().paused = !state

func _on_arena_area_exited(ball: Ball) -> void:
	ball.queue_free()
	player_lives += -1
	if player_lives > -1:
		spawn_ball()
	else:
		game_over()
		
func game_over():
	sub_viewport.get_parent().hide()
	levels.current_level = 0
	await save_prompt()
	player_points = 0
	player_lives = 2
	clear_level()
	call_deferred("inizialize_level")
	sub_viewport.get_parent().show()
	spawn_ball()

	
func save_prompt():
	submit_score_container.show()
	score_menu.show()
	await submit_score_container.score_submit
	score_sheet.scores_array.append({"name": player_name, "score": player_points})
	submit_score_container.hide()
	score_sheet.save_scores()
	score_menu.add_scores(score_sheet)
	await get_tree().create_timer(3).timeout
	score_menu.hide()
	
func clear_level():
	for child in block_lines.get_children():
		child.queue_free()






func _on_submit_score_container_score_submit(passed_name) -> void:
	player_name = passed_name
