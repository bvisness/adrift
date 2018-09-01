extends Spatial

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch

onready var shield = get_node('Shield')
onready var speed = 140;

onready var health_bar = find_node("HealthBar")
onready var hit_stopwatch = SyncStopwatch.new()

const TIME_UNTIL_RECHARGE = 3
const RECHARGE_SPEED = 10.0

var health = 100.0

func _ready():
	hit_stopwatch.start()

func _process(delta):
	hit_stopwatch.process(delta)
	
	if Input.is_key_pressed(KEY_LEFT):
		shield.rotate_y(deg2rad(speed) * delta)
	if Input.is_key_pressed(KEY_RIGHT):
		shield.rotate_y(deg2rad(-speed) * delta)
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	# Recharge health
	if hit_stopwatch.time >= TIME_UNTIL_RECHARGE:
		set_health(health + RECHARGE_SPEED * delta)

func set_health(value):
	health = clamp(float(value), 0, 100)
	health_bar.value = health

func hit(entity):
	set_health(health - entity.DAMAGE)
	entity.kill()
	hit_stopwatch.reset()
