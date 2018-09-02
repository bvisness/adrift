extends Spatial

signal died

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
onready var hit_stopwatch = SyncStopwatch.new()

onready var shield = get_node('Shield')
onready var speed = 140;

onready var UI = find_node("UI")
onready var health_bar = find_node("HealthBar")
onready var sticky_bar = find_node("StickyBar")

const TIME_UNTIL_RECHARGE = 3
const RECHARGE_SPEED = 5.0

var invincible = false
var health = 100.0
var dead = false

const BulletAnchor = preload("res://BulletAnchor.tscn")

const STICKY_PER_BULLET = 0.5
const STICKY_PER_SECOND = 10

var sticky = 100.0
var sticky_active = false
var sticky_anchors = []
onready var anchors_root = get_node('Shield/StickyAnchors')

var input_active = false
var shield_idle_rotate_speed = 10

onready var shield_up_sound = get_node("Sounds/ShieldUp")

func _ready():
	UI.set_alpha(0)
	
	shield.connect_panel_signals("hit", self, "_on_panel_hit")
	hit_stopwatch.start()

func _process(delta):
	hit_stopwatch.process(delta)
	
	if not dead:
		if input_active:
			if Input.is_key_pressed(KEY_LEFT):
				shield.rotate_y(deg2rad(speed) * delta)
			if Input.is_key_pressed(KEY_RIGHT):
				shield.rotate_y(deg2rad(-speed) * delta)
				
			# Handle sticky
			if Input.is_key_pressed(KEY_SPACE):
				set_sticky(sticky - (STICKY_PER_SECOND * delta))
				if sticky_active and sticky <= 0:
					release_stickies()
				if not sticky_active and sticky > 0:
					sticky_anchors = []
					sticky_active = true
					shield_up_sound.play()
			else:
				if sticky_active:
					release_stickies()
				sticky_active = false
		else:
			# idly rotate the shields
			shield.rotate_y(deg2rad(shield_idle_rotate_speed) * delta)
		
		# Yes, I know this happens every time. Whatever.
		shield.set_sticky(sticky_active)

		# Recharge health
		if hit_stopwatch.time >= TIME_UNTIL_RECHARGE:
			set_health(health + RECHARGE_SPEED * delta)

func activate():
	input_active = true
	UI.fade(2, 1)

func set_health(value):
	health = clamp(float(value), 0, 100)
	health_bar.value = health
	
	if health <= 0:
		die()

func hit(entity):
	if not invincible:
		set_health(health - entity.DAMAGE)
		entity.kill()
		hit_stopwatch.reset()

func die():
	emit_signal("died")
	dead = true
	
func set_sticky(value):
	sticky = clamp(float(value), 0, 100)
	sticky_bar.value = sticky

func _on_panel_hit(entity):
	if sticky_active:
		# stick 'em
		var anchor = BulletAnchor.instance()
		anchor.init(entity, shield)
		anchors_root.add_child(anchor)
	else:
		# recharge
		set_sticky(sticky + STICKY_PER_BULLET)

func release_stickies():
	for anchor in anchors_root.get_children():
		anchor.release()
