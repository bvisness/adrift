extends "res://Waves/SimpleEnemyWave.gd"

static func create(orbit_distance, orbit_speed, fire_time, timeout = 10):
	var wave = preload("res://Waves/BasicTriangle.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	wave.timeout = timeout
	
	return wave

func fill_enemy_set(set):
	set.add_array([
		get_node("BasicEnemy1"),
		get_node("BasicEnemy2"),
		get_node("BasicEnemy3"),
	])

func fire(enemies):
	for enemy in enemies.get_valid():
		enemy.fire()
