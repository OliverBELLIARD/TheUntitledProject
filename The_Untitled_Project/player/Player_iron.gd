extends "res://engine/entity.gd"

# swing animation lenght
const swing_anim_lenght = 4
const sec = 60	# 60 cycles in the _pysics_process() loop = 1s

var state = "default"	# State machine variable
var attack_finish = 2

# Damage variables
var harmless = 0
var aggressive = 100
var DAMAGE = aggressive

# Stamina variables
var stamina_max = 10
var stamina = 0
var stamina_counter = 0

# Potions variables
var potions_count = 0
var max_potions_amount = 2
var poison_potions = 0
var health_potions = 0

var coins = 0	# Money variable

func _init():
	TYPE = "PLAYER"
	SPEED = 350
	

func _ready():
	set_physics_process(true)
	$shadow.set("visible", true)
	

# warning-ignore:unused_argument
func _physics_process(delta):
	match state:
		"default":
			state_default()
		"attack":
			if stamina > 1:
				state_attack()
			else:
				state = "default"
				
	potions_count = min(health_potions + poison_potions, max_potions_amount)


func state_default():
	#$anim.stop(false)
	
	control_loop()
	movement_loop()
	sprite_loop()
	damage_loop()
	stamina_loop()
	
	DAMAGE = harmless
	
	if movedir != dir.center:
		anim_switch("running_")
	else:
		anim_switch("guard_")
	
	if Input.is_action_pressed("ATTACK"):
		state = "attack"
	
	if Input.is_action_just_pressed("USE"):
		print("pp: " + str(poison_potions) + " - hp: " + str(health_potions))


func state_attack():
	anim_switch("sword_")
	damage_loop()
	
	DAMAGE = aggressive
	
	if $weapon_area/SwordArea.disabled == false:
		$hitbox/HitboxArea.disabled = true
	else:
		$hitbox/HitboxArea.disabled = false
		
	if $anim.current_animation_position > 1 and $anim.current_animation_position < 2:
		movement_loop()
	
	if $anim.current_animation_position < 3 and Input.is_action_pressed("ATTACK"):
		attack_finish = swing_anim_lenght
	
	if $anim.current_animation_position > 3 and $anim.current_animation_position < 4:
		movement_loop()
		
	if $anim.current_animation_position > attack_finish:
		$anim.stop(true)
		movedir = dir.center
		state = "default"
		stamina -= 2
		attack_finish = 2


func stamina_loop():
	if stamina < stamina_max :
		stamina_counter += 1
	
	if stamina_counter == sec:
		stamina_counter = 0
		stamina += 1


