extends "res://Waves/SimpleEnemyWave.gd"

const BasicEnemy = preload("res://BasicEnemy.tscn")

var num_enemies = 4
var num_firers = 3

var do_spiral = false
var spiral_rotate_speed = 0

var burst_sequence = []

static func create(num_enemies, num_firers, orbit_distance, orbit_speed, fire_time, timeout = 10, burst_size = 1, skip_size = 0):
	var wave = preload("res://Waves/VariableEnemies.tscn").instance()
	wave.num_enemies = num_enemies
	wave.num_firers = num_firers
	wave.orbit_distance = orbit_distance
	wave.orbit_speed = orbit_speed
	wave.fire_time = fire_time
	wave.timeout = timeout
	
	for i in range(0, burst_size):
		wave.burst_sequence.append(true)
	for i in range(0, skip_size):
		wave.burst_sequence.append(false)
	
	return wave

func spiral(rotate_speed):
	self.do_spiral = true
	self.spiral_rotate_speed = rotate_speed
	return self

func fill_enemy_set(set):
	var enemies = []
	for i in range(0, num_enemies):
		var enemy = BasicEnemy.instance()
		enemy.rotate_y(-deg2rad(i * (360 / num_enemies)))
		if do_spiral:
			enemy.fire_type = enemy.SPIRAL
			enemy.spiral_rotate_speed = spiral_rotate_speed
		add_child(enemy)
		enemies.append(enemy)
		
	set.add_array(enemies)

var fire_index = 0
var burst_index = 0
func fire(enemies):
	if burst_sequence[burst_index]:
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

	burst_index = (burst_index + 1) % burst_sequence.size()
