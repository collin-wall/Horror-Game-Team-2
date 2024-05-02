extends Node2D



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
