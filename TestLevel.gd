extends Spatial

const TimerWave = preload("res://Waves/TimerWave.gd")
const BasicTriangle = preload("res://Waves/BasicTriangle.gd")
const TwoTriangles = preload("res://Waves/TwoTriangles.gd")

var waves = [
#	TwoTriangles.create(12, 5, 1),
#	TimerWave.create(1),
	BasicTriangle.create(10, 5, 1),
	TimerWave.create(1),
	BasicTriangle.create(10, 30, 0.5),
	TimerWave.create(1),
	TwoTriangles.create(12, 5, 1),
	preload("res://Waves/OrbitingBulletTest.tscn").instance(),
]
var current_wave = null
var next_wave_index = 0

var player_active = true

onready var player = get_node("Player")

func _ready():
	player.connect("died", self, "_on_player_died")
	next_wave()

func _process(delta):
	if player_active and current_wave and current_wave.is_finished():
		next_wave()

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
	if current_wave:
		current_wave.finish()
