extends "res://Waves/Wave.gd"

var waves = []
var wave_index = 0

static func create(subwaves):
	var wave = preload("res://Waves/SequenceWave.tscn").instance()
	for subwave in subwaves:
		wave.waves.append(weakref(subwave))
	return wave

func _ready():
	add_child(waves[0].get_ref())

func _process(delta):
	var current_wave_dead = !current_wave()
	var current_wave_finished = current_wave() and current_wave().is_finished()
	if current_wave_dead or current_wave_finished:
		advance_to_next()

func finish():
	if current_wave():
		current_wave().finish()

func is_finished():
	return wave_index >= waves.size()

func current_wave():
	if wave_index >= waves.size():
		return null
	
	return waves[wave_index].get_ref()

func advance_to_next():
	wave_index = clamp(wave_index + 1, 0, waves.size())
	if wave_index < waves.size():
		var next_wave = waves[wave_index].get_ref()
		if next_wave:
			add_child(next_wave)
