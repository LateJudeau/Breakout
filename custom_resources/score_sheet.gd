extends Resource
class_name ScoreSheet

var save_path: String = "user://scores.save"

	#scores_array.append({"name": player_name, "score": player_points})
var scores_array: Array

func load_scores():
	if not FileAccess.file_exists(save_path):
		print("no scores loaded")
		return
	
	var saved_scores : String = FileAccess.open(save_path, FileAccess.READ).get_as_text()
	scores_array = JSON.parse_string(saved_scores) as Array
	#var loaded_array = json.parse_string(saved_scores)
	#for item in loaded_array:
		#scores_array.append(json.parse_string(item))
	print("scores loaded")

	

func save_scores():
	scores_array.sort_custom(sort_by_score)
	scores_array = scores_array.slice(0,5)
	var saved_scores : = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(scores_array)
	saved_scores.store_line(json_string)
	print("game saved")




func sort_by_score(a, b):
	if a.score > b.score:
		return true
	return false

