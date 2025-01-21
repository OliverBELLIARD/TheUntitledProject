extends Camera2D

var state = "dungeon"

func _ready():
	$area/CollisionShape2D.position = Vector2(get_viewport().size.x/2, get_viewport().size.y/2) * scale
	$area/CollisionShape2D.shape.extents = Vector2(get_viewport().size.x/2, get_viewport().size.y/2) * scale
	
func _process(delta):
	
	if Input.is_action_just_pressed("SPRINT"):
		if state == "default":
			state = "dungeon"
		if state == "dungeon":
			state = "default"
		
	match state:
		"default":
			state_default(delta)
		"dungeon":
			state_dungeon()
	
func state_default(delta):
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	global_position = get_node("../player").global_position*delta/delta
	
func state_dungeon():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	var pos = get_node("../player").global_position
	var x = floor(pos.x/(get_viewport().size.x)*scale.x) * get_viewport().size.x*scale.x
	var y = floor(pos.y/(get_viewport().size.y)*scale.y) * get_viewport().size.y*scale.y
	
	global_position = Vector2(x,y)
	