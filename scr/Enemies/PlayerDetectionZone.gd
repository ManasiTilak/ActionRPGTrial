extends Node2D

var player = null

func can_see_player():
	return player != null

func _on_body_entered(body):
	player = body


func _on__body_exited(body):
	player = null
