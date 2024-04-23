extends Sprite2D
class_name Follower



var follower_color: int = 1:
	set(value):
		follower_color = value
		match follower_color:
			1:
				modulate = Color("80ff74ff")
			2:
				modulate = Color("ffff27ff")
			3:
				modulate = Color("ff7027ff")
			4:
				modulate = Color("ff2c27ff")
		hit()

func hit():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a", 0,0.5).from_current()
	

