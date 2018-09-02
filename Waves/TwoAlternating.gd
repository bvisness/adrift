extends "res://Waves/SimpleEnemyWave.gd"

static func create(orbit_distance, orbit_speed, fire_time, timeout = 10):
	var wave = preload("res://Waves/TwoAlternating.tscn").instance()
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	wave.timeout = timeout
	
	return wave

func fill_enemy_set(set):
	set.add_array([
		get_node("BasicEnemy"),
		get_node("BasicEnemy2"),
	])

var fireTwo = false
func fire(enemies):
	var enemy_refs = enemies.get_all_refs()
	var i = 1 if fireTwo else 0
	if enemy_refs[i].get_ref():
		enemy_refs[i].get_ref().fire()
	fireTwo = !fireTwo
