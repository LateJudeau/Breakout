extends Resource
class_name Levels

var current_level: int = 0
@export var levels: Array[Level]


func get_next_level() -> Level:
	current_level += 1
	if current_level > len(levels):
		current_level = 0
		return levels[current_level]
	else: 
		return levels[current_level-1]
	
