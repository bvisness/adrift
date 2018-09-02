extends "res://Waves/Wave.gd"

var wave = null

static func create(subwave):
	var wave = preload("res://Waves/OptionalWave.tscn").instance()
	wave.wave = weakref(subwave)
	return wave
	
func _ready():
	add_child(wave.get_ref())

func finish():
	if wave.get_ref():
		wave.get_ref().finish()

func is_finished():
	return true
