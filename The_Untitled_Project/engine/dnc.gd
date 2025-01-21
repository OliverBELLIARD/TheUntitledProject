extends CanvasModulate
# DNC : Day - Night Cycle

export var day_duration	= 1 # Day duration in minutes

var tick = 0
var lenght_day = 0
var hours = 0
var nb_days = 0

enum { DAY, NIGHT }
var cycle = DAY


func _ready():
	# 1s = 60 _pysics_proces cycles
	# 1m = 60s
	lenght_day = 3600 * day_duration
	tick = lenght_day /2 # Start at midday
	
	set_physics_process(true)

# warning-ignore:unused_argument
func _physics_process(delta):
	tick += 1
	day_cycle()


func day_cycle():
	hours = int(tick / (lenght_day/24))
	
	if tick > lenght_day:
		tick = 0
		nb_days += 1
	
	if hours < 7 or hours > 18:
		cycle_change(NIGHT)
	else:
		cycle_change(DAY)
	
#	print("current time: " + str(tick) + "s - " + str(hours) + "h - " + str(nb_days) + "days - cycle:" + str(cycle))


func cycle_change(new_cycle):
	if cycle != new_cycle:
		cycle = new_cycle
		if cycle == NIGHT:
			$twe.interpolate_property(self, "color", col.day, col.night, day_duration*10, Tween.TRANS_SINE, Tween.EASE_IN)
			$twe.start()
			yield($twe, "tween_completed")
		else:
			$twe.interpolate_property(self, "color", col.night, col.day, day_duration*10, Tween.TRANS_SINE, Tween.EASE_IN)
			$twe.start()
			yield($twe, "tween_completed")