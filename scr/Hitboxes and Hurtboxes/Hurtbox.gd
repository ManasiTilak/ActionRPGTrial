extends Area2D

const HitEffect = preload("res://scr/Effects/HitEffect.tscn")



func _create_hit_effect():

	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position



func _on_Timer_timeout():
	self.invincible = false
