extends "res://Waves/SimpleEnemyWave.gd"

var spiral_rotate_speed = 60

static func create(orbit_distance, orbit_speed, fire_time, spiral_rotate_speed, timeout = 10):
	var wave = preload("res://Waves/BasicTriangleSpiral.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	wave.spiral_rotate_speed = spiral_rotate_speed
	wave.timeout = timeout
	
	return wave

func fill_enemy_set(set):
	var enemies = [
		get_node("BasicEnemy1"),
		get_node("BasicEnemy2"),
		get_node("BasicEnemy3"),
	]
	
	for enemy in enemies:
		enemy.spiral_rotate_speed = spiral_rotate_speed

	set.add_array(enemies)

func fire(enemies):
	for enemy in enemies.get_valid():
		enemy.fire()
