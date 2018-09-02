extends "res://Waves/SimpleEnemyWave.gd"

static func create(orbit_distance, orbit_speed, fire_time):
	var wave = preload("res://Waves/TwoTriangles.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	
	return wave

func fill_enemy_set(enemies):
	enemies.add_array([
		get_node("BasicEnemy"),
		get_node("BasicEnemy2"),
		get_node("BasicEnemy3"),
	], "set1")
	enemies.add_array([
		get_node("BasicEnemy4"),
		get_node("BasicEnemy5"),
		get_node("BasicEnemy6"),
	], "set2")

var fire_toggle = false
func fire(enemies):
	var tag = "set1" if fire_toggle else "set2"
	fire_toggle = !fire_toggle
	for enemy in enemies.get_valid(tag):
		enemy.fire()
