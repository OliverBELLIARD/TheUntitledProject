extends "res://items/pickup.gd"


func _process(delta):
	if Input.is_action_pressed("TAKE"):
		for body in get_overlapping_bodies():
			if body.name == "player" and body.get("potions_count") < body.get("max_potions_amount"):
				body.health_potions += 1
				queue_free()