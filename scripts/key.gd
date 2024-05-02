extends Node3D


func _on_interactable_focused(interactor):
	print("working")

func _on_interactable_interacted(interactor):
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_interactable_unfocused(interactor):
	pass
