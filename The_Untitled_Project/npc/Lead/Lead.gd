extends "res://engine/entity.gd"


var movetimer_length = 30
var movetimer = 0

# warning-ignore:unused_class_variable
var DAMAGE = 5

func _init():
	SPEED = 100
	health = 50
	
# warning-ignore:unused_argument
func _physics_process(delta):
	movement_loop()
	damage_loop()
	sprite_loop()
	animS_switch("walking_")
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = movetimer_length