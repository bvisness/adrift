extends Spatial

const Bullet = preload("res://Bullet.tscn")

var rotate_speed = 60
var move_speed = 3

onready var rotator = self
onready var positioner = get_node("BulletPositioner")

onready var bullet = null

func _ready():
	pass

func init_at(position):
	var newBullet = Bullet.instance()
	newBullet.init_controlled(self)
	
	positioner.global_transform.origin = position
	newBullet.global_transform.origin = position
	
	get_node("/root/GameRoot/Player/Bullets").add_child(newBullet)
	
	bullet = weakref(newBullet)

func _process(delta):
	var dist = positioner.translation.length()
	if positioner.translation.length() < 1:
		queue_free()
	
	positioner.translate(-positioner.translation.normalized() * move_speed * delta)
	rotate_y(deg2rad(rotate_speed) * delta)
	
	move_bullet()

func move_bullet():
	if bullet.get_ref():
		bullet.get_ref().move_to(positioner.global_transform.origin)

func relinquish_bullet_control():
	queue_free()
