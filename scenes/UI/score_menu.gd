extends Control
class_name ScoreMenu

@onready var v_box_container: VBoxContainer = $VBoxContainer
const SCORE_LABELS = preload("res://scenes/UI/score_labels.tscn")

var placeholder_scores: Array[Dictionary] = [{"name": "example1", "score": 500},{"name": "example2", "score": 300},{"name": "example3", "score": 201}]


#func _ready() -> void:
	#add_scores(placeholder_scores)



func add_scores(scores: ScoreSheet):
	var score_array: Array = scores.scores_array
	for child: Node in v_box_container.get_children().slice(1):
		child.queue_free()
		
	
	#var score_array: Array = scores
	for i in range(len(score_array)):
		var this_score = SCORE_LABELS.instantiate()
		v_box_container.add_child(this_score)
		score_array[i]["number"] = i + 1
		this_score.add_score(score_array[i])
