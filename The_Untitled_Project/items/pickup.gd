extends Area2D
# get_node(self.get_path()).function()
# useful if working with a function that is not in the top class

export(bool) var disapears = false

func _ready():
	$anim.play("floating")
	connect("body_entered", self, "body_entered")
	connect("area_entered", self, "area_entered")
	connect("body_exited", self, "body_exited")
	connect("area_exited", self, "area_exited")
	
func area_entered(area):
	var area_parent = area.get_parent()
	if area_parent.name == "player":
		body_entered(area_parent)

func area_exited(area):
	var area_parent = area.get_parent()
	if area_parent.name == "player":
		body_exited(area_parent)

func body_entered(body):
	if body.name == "player":
		set_process(true)

func body_exited(body):
	if body.name == "player":
		set_process(false)