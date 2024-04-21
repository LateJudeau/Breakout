extends Resource
class_name Levels

var current_level: int = 0
@export var levels: Array[Level]


func get_next_level() -> Level:
	current_level += 1
	return levels[current_level-1]
	
