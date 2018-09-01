extends Spatial

signal died

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var hit_stopwatch = SyncStopwatch.new()

onready var shield = get_node('Shield')
onready var speed = 140;

onready var health_bar = find_node("HealthBar")

const TIME_UNTIL_RECHARGE = 3
const RECHARGE_SPEED = 5.0

var health = 100.0
var dead = false

func _ready():
	hit_stopwatch.start()

func _process(delta):
	hit_stopwatch.process(delta)
	
	if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
	
	if not dead:
		if Input.is_key_pressed(KEY_LEFT):
			shield.rotate_y(deg2rad(speed) * delta)
		if Input.is_key_pressed(KEY_RIGHT):
			shield.rotate_y(deg2rad(-speed) * delta)

		# Recharge health
		if hit_stopwatch.time >= TIME_UNTIL_RECHARGE:
			set_health(health + RECHARGE_SPEED * delta)

func set_health(value):
	health = clamp(float(value), 0, 100)
	health_bar.value = health
	
	if health <= 0:
		die()

func hit(entity):
	set_health(health - entity.DAMAGE)
	entity.kill()
	hit_stopwatch.reset()

func die():
	emit_signal("died")
	dead = true
