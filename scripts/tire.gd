extends Node3D


func _on_interactable_focused(interactor):
	pass

func _on_interactable_interacted(interactor):
	queue_free()

func _on_interactable_unfocused(interactor):
	pass
