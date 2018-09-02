extends "res://Waves/SimpleEnemyWave.gd"

const BasicEnemy = preload("res://BasicEnemy.tscn")

var num_enemies = 4
var num_firers = 3

static func create(num_enemies, orbit_distance, orbit_speed, fire_time, timeout = 10):
	var wave = preload("res://Waves/VariableEnemies.tscn").instance()
	wave.num_enemies = num_enemies
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	wave.timeout = timeout
	
	return wave

func fill_enemy_set(set):
	var enemies = []
	for i in range(0, num_enemies):
		var enemy = BasicEnemy.instance()
		enemy.rotate_y(-deg2rad(i * (360 / num_enemies)))
		add_child(enemy)
		enemies.append(enemy)
		
	set.add_array(enemies)

var fire_index = 0
func fire(enemies):
	var indices = []
	for i in range(0, num_firers):
		var new_index = (fire_index + i * (num_enemies / num_firers)) % num_enemies
		indices.append(new_index)

	for i in indices:	
		var enemy_refs = enemies.get_all_refs()
		var enemy = enemy_refs[i].get_ref()
		
		if enemy:
			enemy.fire()
	
	fire_index = (fire_index + 1) % num_enemies
