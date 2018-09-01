extends "res://Waves/Wave.gd"

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var begin_stopwatch = SyncStopwatch.new()
onready var fire_stopwatch = SyncStopwatch.new()

const SafeEnemySet = preload("res://Waves/SafeEnemySet.gd")
onready var enemies = SafeEnemySet.new()

var orbit_distance = 12
var orbit_speed = 5
var fire_time = 1
var timeout = 10

var shooting_active = false

static func create(orbit_distance, orbit_speed, fire_time):
	var wave = preload("res://Waves/TwoTriangles.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	
	return wave

func init_enemy(name):
	var e = get_node(name)
	e.init(orbit_distance, orbit_speed)
	return e

func _ready():
	enemies.add_array([
		init_enemy("BasicEnemy"),
		init_enemy("BasicEnemy2"),
		init_enemy("BasicEnemy3"),
	], "set1")
	enemies.add_array([
		init_enemy("BasicEnemy4"),
		init_enemy("BasicEnemy5"),
		init_enemy("BasicEnemy6"),
	], "set2")
	
	begin_stopwatch.start()

var fire_toggle = false
func _process(delta):
	begin_stopwatch.process(delta)
	fire_stopwatch.process(delta)
	
	if not fire_stopwatch.is_running and begin_stopwatch.time > 2:
		begin_stopwatch.stop()
		fire_stopwatch.start()
	
	if fire_stopwatch.time > fire_time:
		fire_stopwatch.reset(fire_time)
		var tag = "set1" if fire_toggle else "set2"
		fire_toggle = !fire_toggle
		for enemy in enemies.get_valid(tag):
			enemy.fire()

func is_finished():
	return (
		enemies.get_valid().size() == 0
#		|| timeout_stopwatch.time > timeout + 1
	)
	