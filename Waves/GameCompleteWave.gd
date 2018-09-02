extends "res://Waves/Wave.gd"

signal show_game_complete

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var stopwatch = SyncStopwatch.new()

static func create(receiver):
	var wave = preload("res://Waves/GameCompleteWave.tscn").instance()
	
	wave.connect("show_game_complete", receiver, "_on_show_game_complete")
	
	return wave

func _ready():
	emit_signal("show_game_complete")
	stopwatch.start()
	
func _process(delta):
	stopwatch.process(delta)

func finish():
	pass

func is_finished():
	return stopwatch.time >= 3
