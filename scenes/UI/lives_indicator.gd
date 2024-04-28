extends Control
class_name LivesIndicator

const BALL_UI = preload("res://scenes/UI/ball_ui.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer



func update_lives(value: int):
	for child in h_box_container.get_children():
		child.queue_free()
		
		
	for i in range(value):
		var ball_ui = BALL_UI.instantiate()
		h_box_container.add_child(ball_ui)

