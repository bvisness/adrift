extends Spatial

const TimerWave = preload("res://Waves/TimerWave.gd")
const BasicTriangle = preload("res://Waves/BasicTriangle.gd")
const TwoTriangles = preload("res://Waves/TwoTriangles.gd")

var waves = [
	TwoTriangles.create(12, 5, 1),
	TimerWave.create(1),
	BasicTriangle.create(10, 5, 1),
	TimerWave.create(1),
	BasicTriangle.create(10, 30, 0.5),
	TimerWave.create(1),
	TwoTriangles.create(12, 5, 1),
	preload("res://Waves/OrbitingBulletTest.tscn").instance(),
]
var current_wave = null
var next_wave_index = 0

func _ready():
	next_wave()

func _process(delta):
	if current_wave.is_finished():
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
