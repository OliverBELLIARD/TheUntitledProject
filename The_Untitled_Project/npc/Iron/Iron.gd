extends "res://engine/entity.gd"

# swing animation lenght
const swing_anim_lenght = 4

var state = "default"
var DAMAGE = 10

func _init():
	SPEED = 120
	
func _ready():
	set_physics_process(true)
	get_child(0).set("visible", true)

# warning-ignore:unused_argument
func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()

func state_default():
	control_loop()
	movement_loop()
	sprite_loop()
	damage_loop()
	
	if movedir != dir.center:
		anim_switch("running_")
	else:
		anim_switch("guard_")
	
	if Input.is_action_pressed("ATTACK"):
		state = "swing"

func state_swing():
	anim_switch("sword_")
	damage_loop()
	
	if $anim.current_animation_position > 1 and $anim.current_animation_position < 2:
		movement_loop()
	if $anim.current_animation_position > 3 and $anim.current_animation_position < swing_anim_lenght:
		movement_loop()

func set_state_default():
	state = "default"
	
func control_loop():
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)

func _on_SwordHit_area_entered(area):
	if area.is_in_group("hitbox"):
		area.damage_loop()
