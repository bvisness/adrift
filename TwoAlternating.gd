extends "res://Waves/Wave.gd"

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var begin_stopwatch = SyncStopwatch.new()
onready var fire_stopwatch = SyncStopwatch.new()
onready var timeout_stopwatch = SyncStopwatch.new()
onready var finish_stopwatch = SyncStopwatch.new()

var orbit_distance = 10
var orbit_speed = 30
var fire_time = 0.5
var timeout = 10
var finish_time = 0.5

var shooting_active = false

const SafeEnemySet = preload("res://Waves/SafeEnemySet.gd")
onready var enemies = SafeEnemySet.new()

static func create(orbit_distance, orbit_speed, fire_time):
	var wave = preload("res://Waves/BasicTriangle.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	
	return wave

func init_enemy(name):
	var e = get_node(name)
	e.init(orbit_distance, orbit_speed)
	e.invincible = true
	return e

func _ready():		
	enemies.add_array([
		init_enemy("BasicEnemy1"),
		init_enemy("BasicEnemy2"),
	])
	begin_stopwatch.start()

func _process(delta):
	begin_stopwatch.process(delta)
	fire_stopwatch.process(delta)
	timeout_stopwatch.process(delta)
	finish_stopwatch.process(delta)
	
	if not fire_stopwatch.is_running and begin_stopwatch.time >= 2:
		shooting_active = true
		begin_stopwatch.stop()
		fire_stopwatch.start()
		timeout_stopwatch.start()
		for enemy in enemies.get_valid():
			enemy.invincible = false
	
	if shooting_active and fire_stopwatch.time > fire_time:
		fire_stopwatch.reset(fire_time)
		for enemy in enemies.get_valid():
			enemy.fire()
	
	if timeout_stopwatch.time > timeout:
		finish()

func finish():
	finish_stopwatch.start()
	shooting_active = false
	for enemy in enemies.get_valid():
		enemy.orbitDistance = 50

func is_finished():
	return (
		enemies.get_valid().size() == 0
		|| finish_stopwatch.time > finish_time
	)