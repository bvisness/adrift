extends "res://Waves/SimpleEnemyWave.gd"

var burst_sequence = []

static func create(orbit_distance, orbit_speed, fire_time, burst_size, skip_size, timeout = 10):
	var wave = preload("res://Waves/BasicTriangleBurst.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	wave.timeout = timeout
	
	for i in range(0, burst_size):
		wave.burst_sequence.append(true)
	for i in range(0, skip_size):
		wave.burst_sequence.append(false)
	
	return wave

func fill_enemy_set(set):
	set.add_array([
		get_node("BasicEnemy1"),
		get_node("BasicEnemy2"),
		get_node("BasicEnemy3"),
	])

var shot_index = 0
func fire(enemies):
	if burst_sequence[shot_index]:
		for enemy in enemies.get_valid():
			enemy.fire()
	shot_index = (shot_index + 1) % burst_sequence.size()
