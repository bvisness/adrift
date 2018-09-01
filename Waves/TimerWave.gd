extends "res://Waves/Wave.gd"

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var stopwatch = SyncStopwatch.new()

var timeout = 1

static func create(timeout):
	var wave = preload("res://Waves/TimerWave.tscn").instance()
	wave.timeout = timeout
	return wave

func _ready():
	stopwatch.start()

func _process(delta):
	stopwatch.process(delta)

func is_finished():
	return stopwatch.time >= timeout
