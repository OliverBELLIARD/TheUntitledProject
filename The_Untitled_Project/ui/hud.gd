extends CanvasLayer


onready var player = get_node("../player")


func _process(delta):
	numbers_update()
	bars_update()

func numbers_update():
	$amo.text = str(player.get("stamina"))
	$bombs.text = str(player.get("potions_count"))

func bars_update():
	$health.max_value = player.get("MAXHEALTH")
	$health.value = player.get("health")
	
	$stamina.max_value = player.get("stamina_max")
	$stamina.value = player.get("stamina")