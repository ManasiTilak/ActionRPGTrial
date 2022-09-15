#This script hendles animations and is share with animated sprits of grass ka getting cut wala effect,
# bat ka dying wala effect and the animation sword hit ka

extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	play("Animate")


func _on_animation_finished():
	queue_free() #this quefree , frees the animation NOT the player, enemy or object
	pass
