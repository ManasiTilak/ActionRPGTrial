extends KinematicBody2D

const EnemyDeathEffect = preload("res://scr/Effects/EnemyDeathEffect.tscn")
const KNOCKBACK_FRICTION = 100

export var BAT_FRICTION = 200
export var ACCELERTION = 300
export var MAX_SPEED = 50

enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE
var knockback = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone

func _physics_process(delta):
	
	knockback = knockback.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION *delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, BAT_FRICTION * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERTION * delta)
				sprite.flip_h = velocity.x < 0
			else:
				state = IDLE
	
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
			
func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * KNOCKBACK_FRICTION


func _on_Stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance() #this is coming from the const you have preloaded
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	
