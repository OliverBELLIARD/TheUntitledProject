extends KinematicBody2D

const MAXHEALTH = 100

var TYPE = "ENEMY"
var SPEED = 0

var movedir = dir.center
var knockdir = dir.center
var spritedir = "back"

var hitstun_timer = 5
var hitstun = 0

var health = MAXHEALTH

var texture_default = null
var texture_hurt	= null

var max_potion_effects = 2

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 200
		
	move_and_slide(motion, dir.center)

func control_loop():
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)

func sprite_loop():
	match movedir:
		dir.left:
			spritedir = "left"
		dir.right:
			spritedir = "right"
		dir.up:
			spritedir = "front"
		dir.down:
			spritedir = "back"

# Animation switch for animated sprites
func animS_switch(animation):
	var newanim = str(animation,spritedir)
	if $anim.animation != newanim:
		$anim.animation = newanim
		
# Animation switch for animation player node
func anim_switch(animation):
	var newanim = str(animation,spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if TYPE != "PLAYER" && health <= 0:
			queue_free()
			
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = hitstun_timer
			knockdir = transform.origin - body.transform.origin

func use_item(item):
	var newitem = item.instance()
	
	newitem.add_to_group(str(item, self))
	add_child(newitem)
	
	if get_tree().get_nodes_in_group(str(item, self)) > newitem.maxamount:
		newitem.queue_free()


