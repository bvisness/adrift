extends Spatial

const TimerWave = preload("res://Waves/TimerWave.gd")
const DialogueWave = preload("res://Waves/DialogueWave.gd")
const WaveComplete = preload("res://Waves/WaveCompleteWave.gd")
const MultiWave = preload("res://Waves/MultiWave.gd")
const SequenceWave = preload("res://Waves/SequenceWave.gd")
const OptionalWave = preload("res://Waves/OptionalWave.gd")
const BasicTriangle = preload("res://Waves/BasicTriangle.gd")
const BasicTriangleBurst = preload("res://Waves/BasicTriangleBurst.gd")
const BasicTriangleSpiral = preload("res://Waves/BasicTriangleSpiral.gd")
const TwoTriangles = preload("res://Waves/TwoTriangles.gd")
const VariableEnemies = preload("res://Waves/VariableEnemies.gd")
const TwoAlternating = preload("res://Waves/TwoAlternating.gd")

var waves_test = [
#	MultiWave.create([
#		BasicTriangle.create(12, 15, 1, 30),
#		SequenceWave.create([
#			TimerWave.create(2),
#			BasicTriangle.create(12, 15, 1, 30),
#		]),
#		SequenceWave.create([
#			TimerWave.create(4),
#			BasicTriangle.create(12, 15, 1, 30),
#		]),
#		SequenceWave.create([
#			TimerWave.create(6),
#			BasicTriangle.create(12, 15, 1, 30),
#		]),
#		SequenceWave.create([
#			TimerWave.create(8),
#			BasicTriangle.create(12, 15, 1, 30),
#		]),
#	]),
	TwoAlternating.create(12, 5, 0.65, 10),
	TimerWave.create(2),
	VariableEnemies.create(40, 15, -15, 0.1, 999999),
	TimerWave.create(3),
	MultiWave.create([
		VariableEnemies.create(15, 15, 15, 0.5, 999999),
		VariableEnemies.create(15, 18, 17, 0.5, 999999),
	]),
	BasicTriangleSpiral.create(10, 5, 1, 60),
	TwoTriangles.create(12, 5, 1),
	TimerWave.create(1),
	DialogueWave.create(self, 3, "We're under attack! Keep our shields up!"),
	BasicTriangle.create(10, 5, 1),
	TimerWave.create(1),
	BasicTriangle.create(10, 30, 0.5),
	TimerWave.create(1),
	MultiWave.create([
		DialogueWave.create(self, 3, "They're everywhere!"),
		TwoTriangles.create(12, 5, 1),
	]),
	MultiWave.create([
		BasicTriangleSpiral.create(10, 10, 1, 50),
		BasicTriangleSpiral.create(13.5, -10, 1, -50),
	]),
]
var waves = [
#	MultiWave.create([
#		VariableEnemies.create(1, 1, 10, -5, 1, 20).rotate(-45),
#		OptionalWave.create(SequenceWave.create([
#			TimerWave.create(10),
#			DialogueWave.create(self, 5, "Try to reflect their shots back at them!"),
#		])),
#	]),
#	TimerWave.create(1),
#	BasicTriangle.create(10, 5, 1, 20),
#	TimerWave.create(1),
#	MultiWave.create([
#		TwoAlternating.create(12, 5, 0.65, 10).rotate(20),
#		DialogueWave.create(self, 3, "Watch your backside!"),
#	]),
#	TwoTriangles.create(12, 5, 1),
#	TimerWave.create(0.5),
#	WaveComplete.create(self),
	
#	DialogueWave.create(self, 4, "You haven't forgotten about our attractor field, have you?"),
#	MultiWave.create([
#		DialogueWave.create(self, 5, "Hold space to absorb bullets and shoot them back!"),
#		BasicTriangleBurst.create(10, 20, .3, 4, 8, 20),
#	]),
#	TimerWave.create(0.5),
#	MultiWave.create([
#		BasicTriangleBurst.create(10, -20, .3, 4, 8, 20),
#		SequenceWave.create([
#			TimerWave.create(0.3),
#			BasicTriangleBurst.create(12, 20, .3, 4, 8, 20),
#		]),
#	]),
#	VariableEnemies.create(9, 3, 10, 15, 0.4, 10, 3, 3),
#	MultiWave.create([
#		VariableEnemies.create(3, 3, 10, 15, 1, 15),
#		VariableEnemies.create(3, 3, 10, 15.5, 1, 15).rotate(5),
#		VariableEnemies.create(3, 3, 10, 16, 1, 15).rotate(10),
#		VariableEnemies.create(3, 3, 10, 16.5, 1, 15).rotate(15),
#		VariableEnemies.create(3, 3, 10, 17, 1, 15).rotate(20),
#	]),
#	TimerWave.create(0.5),
#	WaveComplete.create(self),
	
#	DialogueWave.create(self, 3, "More on our scanners. These look...different."),
#	MultiWave.create([
#		BasicTriangleSpiral.create(10, 5, 1, 60),
#		SequenceWave.create([
#			TimerWave.create(3.5),
#			DialogueWave.create(self, 2, "Whoa!"),
#		]),
#	]),
#	TimerWave.create(1),
#	MultiWave.create([
#		VariableEnemies.create(3, 3, 10, 5, 1.2, 10, 1, 0).spiral(25),
#		SequenceWave.create([
#			TimerWave.create(0.6),
#			VariableEnemies.create(3, 3, 10, 5, 1.2, 10, 1, 0).spiral(-25).rotate(-55),
#		]),
#	]),
#	MultiWave.create([
#		VariableEnemies.create(3, 3, 10, 24, 0.3, 10, 3, 3).spiral(40),
#		VariableEnemies.create(3, 3, 10, 20, 0.3, 10, 3, 3).spiral(40).rotate(-5),
#	]),
#	TimerWave.create(1),
	MultiWave.create([
		VariableEnemies.create(3, 3, 10, 20, 0.3, 20, 4, 4).spiral(40),
		SequenceWave.create([
			TimerWave.create(1.2),
			VariableEnemies.create(3, 3, 12, 10, 0.3, 20, 4, 4),
		]),
	]),
	TimerWave.create(1),
	WaveComplete.create(self),
]
var current_wave = null
var next_wave_index = 0

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var dialogue_stopwatch = SyncStopwatch.new()
onready var wave_complete_stopwatch = SyncStopwatch.new()

var player_active = true

onready var player = get_node("Player")
onready var game_over = find_node("GameOver")
onready var wave_complete = find_node("WaveComplete")
onready var wave_complete_player = find_node("WaveCompletePlayer")

onready var dialogue_container = get_node("UI/VBoxContainer/DialogueContainer")
onready var dialogue_label = get_node("UI/VBoxContainer/DialogueContainer/Dialogue")
var dialogue_active = false
var dialogue_duration = 1

func _ready():
	player.connect("died", self, "_on_player_died")
	game_over.visible = false
	wave_complete.visible = false
	next_wave()

func _process(delta):
	dialogue_stopwatch.process(delta)
	wave_complete_stopwatch.process(delta)

	if player_active and current_wave and current_wave.is_finished():
		next_wave()
	
	# Kill the active dialogue if it's expired
	if dialogue_active and dialogue_stopwatch.time > dialogue_duration:
		dialogue_container.visible = false
		dialogue_active = false
		dialogue_stopwatch.stop()
	
	# Hide "wave complete" after a time
	if wave_complete.visible and wave_complete_stopwatch.time > 1.5:
		wave_complete.visible = false
		wave_complete_stopwatch.stop()

func next_wave():
	if next_wave_index < waves.size():
		if current_wave:
			current_wave.queue_free()
		
		var new_wave = waves[next_wave_index]
		current_wave = new_wave
		add_child(new_wave)
		next_wave_index += 1
	else:
		get_tree().quit()

func _on_player_died():
	player_active = false
	game_over.visible = true
	if current_wave:
		current_wave.finish()

func _on_dialogue_wave(text, duration):
	dialogue_stopwatch.reset()
	dialogue_stopwatch.start()
	
	dialogue_duration = duration
	dialogue_active = true
	dialogue_label.text = text
	dialogue_container.visible = true	

func _on_show_wave_complete():
	wave_complete_stopwatch.reset()
	wave_complete_stopwatch.start()
	wave_complete.visible = true
	wave_complete_player.play()
