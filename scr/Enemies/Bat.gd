extends KinematicBody2D

const DeathEffect = preload("res://scr/Effects/EnemyDeathEffect.tscn")
const BAT_FRICTION = 100

var knockback = Vector2.ZERO

onready var stats = $Stats

func _physics_process(delta):
	
	knockback = knockback.move_toward(Vector2.ZERO, BAT_FRICTION *delta)
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * BAT_FRICTION


func _on_Stats_no_health() -> void:
	queue_free()
	
