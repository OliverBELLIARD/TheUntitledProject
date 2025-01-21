extends StaticBody2D


func _on_area_area_entered(area):
	if area.get_parent().get("TYPE") != null:
		area.get_parent().get_node("Sprite").modulate = col.shadow


func _on_area_area_exited(area):
	if area.get_parent().get("TYPE") != null:
		area.get_parent().get_node("Sprite").modulate = col.day
