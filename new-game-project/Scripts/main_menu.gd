extends Control

@export var StartSceneFilePath : String = "res://level1.tscn"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(StartSceneFilePath)
