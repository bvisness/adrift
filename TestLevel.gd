extends Spatial

const TimerWave = preload("res://Waves/TimerWave.gd")
const DialogueWave = preload("res://Waves/DialogueWave.gd")
const MultiWave = preload("res://Waves/MultiWave.gd")
const BasicTriangle = preload("res://Waves/BasicTriangle.gd")
const BasicTriangleSpiral = preload("res://Waves/BasicTriangleSpiral.gd")
const TwoTriangles = preload("res://Waves/TwoTriangles.gd")
const VariableEnemies = preload("res://Waves/VariableEnemies.gd")
const TwoAlternating = preload("res://Waves/TwoAlternating.gd")

var waves = [
	TwoAlternating.create(12, 5, 0.65, 10),
	VariableEnemies.create(40, 15, -15, 0.1, 999999),
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
	preload("res://Waves/OrbitingBulletTest.tscn").instance(),
]
var current_wave = null
var next_wave_index = 0

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var dialogue_stopwatch = SyncStopwatch.new()

var player_active = true

onready var player = get_node("Player")
onready var game_over = find_node("GameOver")

onready var dialogue_container = get_node("UI/VBoxContainer/DialogueContainer")
onready var dialogue_label = get_node("UI/VBoxContainer/DialogueContainer/Dialogue")
var dialogue_active = false
var dialogue_duration = 1

func _ready():
	player.connect("died", self, "_on_player_died")
	game_over.visible = false
	next_wave()

func _process(delta):
	dialogue_stopwatch.process(delta)

	if player_active and current_wave and current_wave.is_finished():
		next_wave()
	
	# Kill the active dialogue if it's expired
	if dialogue_active and dialogue_stopwatch.time > dialogue_duration:
		dialogue_container.visible = false
		dialogue_active = false
		dialogue_stopwatch.stop()

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
