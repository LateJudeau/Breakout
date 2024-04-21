extends Area2D
class_name Paddle

@onready var right_marker: Marker2D = $RightMarker
@onready var left_marker: Marker2D = $LeftMarker
@onready var arena: Arena = get_tree().get_first_node_in_group("arena")
var LEFT_STOP: float
var RIGHT_STOP: float 


func _ready() -> void:
	arena.ready.connect(on_arena_ready)

func on_arena_ready():
	RIGHT_STOP = arena.arena_width - right_marker.position.x
	LEFT_STOP = (left_marker.position.x) * -1

func set_paddle_position():
	#print(right_marker.position.x)
	#print(arena.arena_width)
	#print(RIGHT_STOP)
	var new_pos := get_global_mouse_position().x
	global_position.x = clamp(new_pos, LEFT_STOP, RIGHT_STOP)
	


func _physics_process(_delta: float) -> void:
	set_paddle_position()


	
#enum player_types {COMPUTER, PLAYER_ONE, PLAYER_TWO}
#
#@onready var timer: Timer = $Timer
#@export var platform_speed: float
#@export var player_type: player_types:
	#set(type):
		#player_type = type
		#var player_prefix: String = ""
		#if player_type == 1:
			#player_prefix = "P1_"
		#elif player_type == 2:
			#player_prefix = "P2_"
			#if timer is Timer:
				#timer.stop()
		#else:
			#timer.start()
		#inputs["up"] = player_prefix+"up" 
		#inputs["down"] = player_prefix+"down"
#var inputs: Dictionary = {}
#var input_direction: int = 0:
	#set(value):
		#match value:
			#0:
				#input_direction = value
			#1:
				#if not is_wall_hit["bot"]:
					#input_direction = value
				#else:
					#input_direction = 0
			#-1:
				#if not is_wall_hit["top"]:
					#input_direction = value
				#else:
					#input_direction = 0
			#_:
				#if player_type != 0:
					#push_error("unhandled inputdirection")
				
#var ball: Ball:
	#set(new_ball):
		#ball = new_ball
		#if ball is Ball:
			#ball.tree_exiting.connect(on_tree_exiting)
		
#
#var is_wall_hit: Dictionary = {"top": false, "bot": false}

#func _ready() -> void:
	#if player_type != 0:
		#timer.stop()


	#global_position += (Vector2(0 ,input_direction) * platform_speed)* delta
		#velocity = Input.get_vector("na" ,"na" ,inputs["up"],inputs["down"]) * platform_speed
		#move_and_slide()


#func _on_wall_detector_body_entered(body: Node2D) -> void:
	#if body.is_in_group("top_wall"):
		#is_wall_hit["top"] = true
	#elif body.is_in_group("bot_wall"):
		#is_wall_hit["bot"] = true
	#input_direction = 0
#
#func _on_wall_detector_body_exited(body: Node2D) -> void:
	#if body.is_in_group("top_wall"):
		#is_wall_hit["top"] = false
	#elif body.is_in_group("bot_wall"):
		#is_wall_hit["bot"] = false

#func get_cpu_movement():
	#if ball is Ball:
		#var cpu_input_direction = global_position.y - ball.global_position.y 
		##print(cpu_input_direction)
		#if not(cpu_input_direction > 30 or cpu_input_direction < -30):
			#input_direction = 0
			#return
		#if cpu_input_direction < 0:
			#input_direction = 1
		#if cpu_input_direction > 0:
			#input_direction = -1
	#else:
		#ball = get_tree().get_first_node_in_group("ball")
		#return

#func on_tree_exiting():
	#ball = null



#
#func _on_timer_timeout() -> void:
	#get_cpu_movement()
