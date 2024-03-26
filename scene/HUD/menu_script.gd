extends VBoxContainer

func _on_btn_instructions_pressed():
	get_tree().change_scene_to_file("res://scene/HUD/instructions.tscn")


func _on_btn_start_pressed():
	get_tree().change_scene_to_file("res://scene/Main/game.tscn")
