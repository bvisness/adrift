extends "res://Waves/Wave.gd"

const BulletRotator = preload("res://BulletRotator.tscn")

onready var enemy = get_node("MeshInstance")

func _ready():
	pass

var was_pressed = false
func _process(delta):
	if not was_pressed and Input.is_key_pressed(KEY_SPACE):
		spawn_bullet()
		was_pressed = true
	elif not Input.is_key_pressed(KEY_SPACE):
		was_pressed = false

func is_finished():
	return false

func spawn_bullet():
	var rotator = BulletRotator.instance()
	get_node("/root/GameRoot/Player/Bullets").add_child(rotator)
	rotator.init_at(enemy.global_transform.origin)
