extends HBoxContainer
class_name ScoreLabel

@onready var number_label: Label = $NumberLabel
@onready var name_label: Label = $NameLabel
@onready var score_label: Label = $ScoreLabel
@export var bold_text: bool = false:
	set(cond):
		bold_text = cond
		var value = 0
		if cond == true: 
			value = 10
		_change_to_bold(number_label,value)
		_change_to_bold(name_label,value)
		_change_to_bold(score_label,value)


var score_placeholder = {"number": 1, "name": "example", "score": 0}


func add_score(score: Dictionary):
	number_label.text = str(score.number)+"."
	name_label.text = score.name
	score_label.text = str(score.score)





func _change_to_bold(label: Label, value) -> void:
	if label is Label:
		label.add_theme_constant_override("outline_size", value)
	else:
		return
