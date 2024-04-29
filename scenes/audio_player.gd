extends Node
class_name Audio

@onready var start_sound: AudioStreamPlayer = $StartSound
@onready var block_destroyed: AudioStreamPlayer = $BlockDestroyed
@onready var wall_hit: AudioStreamPlayer = $WallHit
@onready var ball_out: AudioStreamPlayer = $BallOut


func play_new_ball():
	start_sound.play(0.04)


func play_paddle_hit():
	play_wall_hit()

func play_wall_hit():
	wall_hit.play()
	
func play_block_hit():
	block_destroyed.play()

func play_ball_out():
	ball_out.play(0.1)
