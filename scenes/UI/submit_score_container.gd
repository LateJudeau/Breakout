extends HBoxContainer


@onready var submit_button: Button = $SubmitButton
@onready var text_edit: LineEdit = $TextEdit
signal score_submit


func _on_text_edit_text_changed(_text) -> void:
	submit_button.disabled = not len(text_edit.text) > 0
		 


func _on_submit_button_button_up() -> void:
	score_submit.emit(text_edit.text)
	
func _on_text_edit_text_submitted(_new_text: String) -> void:
	if submit_button.disabled == false:
		_on_submit_button_button_up()
