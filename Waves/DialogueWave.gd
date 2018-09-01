extends "res://Waves/Wave.gd"

signal say_dialogue(text, duration)

var duration = 4
var text = "Watch out!"

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var stopwatch = SyncStopwatch.new()

static func create(receiver, duration, text):
	var wave = preload("res://Waves/DialogueWave.tscn").instance()
	wave.duration = duration
	wave.text = text
	
	wave.connect("say_dialogue", receiver, "_on_dialogue_wave")
	
	return wave

func _ready():
	emit_signal("say_dialogue", text, duration)
	stopwatch.start()
	
func _process(delta):
	stopwatch.process(delta)

func finish():
	pass

func is_finished():
	return stopwatch.time >= duration
