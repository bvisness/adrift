extends "res://Waves/Wave.gd"

var waves = []

static func create(subwaves):
	var wave = preload("res://Waves/MultiWave.tscn").instance()
	for subwave in subwaves:
		wave.waves.append(weakref(subwave))
	return wave

func _ready():
	for wave in waves:
		add_child(wave.get_ref())

func finish():
	for wave in waves:
		if wave.get_ref():
			wave.get_ref().finish()

func is_finished():
	var all_finished = true
	for wave in waves:
		if wave.get_ref() and not wave.get_ref().is_finished():
			all_finished = false
			break
	
	return all_finished
