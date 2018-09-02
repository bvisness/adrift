extends Spatial

signal killed(enemy)

const Bullet = preload("res://Bullet.tscn")
const BulletRotator = preload("res://BulletRotator.tscn")

onready var body = get_node("KinematicBody")

var orbitSpeed = 10
var orbitDistance = 8

var distanceLerpAmount = 1.4

var invincible = false
var hits_left = 2

enum FireType { NORMAL, SPIRAL }
export(FireType) var fire_type = NORMAL

export(float) var bullet_speed = 4
export(float) var spiral_rotate_speed = 60

func _ready():
	if not fire_type:
		fire_type = NORMAL

	body.translation = Vector3(-50, 0, 0)

func _process(delta):
	rotate_y(deg2rad(orbitSpeed) * delta)
	body.translation.x = lerp(body.translation.x, -orbitDistance, distanceLerpAmount * delta)

func init(orbitDistance, orbitSpeed):
	self.orbitSpeed = orbitSpeed
	self.orbitDistance = orbitDistance

func die():
	emit_signal("killed", self)
	queue_free()

func hit(bullet):
	if not invincible:
		bullet.kill()
		hits_left -= 1
		if hits_left <= 0:
			die()

func fire():
	match fire_type:
		NORMAL:
			var bullet = Bullet.instance()
			bullet.global_transform = body.global_transform
			get_node("/root/GameRoot/Player/Bullets").add_child(bullet)
		SPIRAL:
			var rotator = BulletRotator.instance()
			rotator.rotate_speed = spiral_rotate_speed
			get_node("/root/GameRoot/Player/Bullets").add_child(rotator)
			rotator.init_at(body.global_transform.origin)

func set_invincible(i):
	invincible = i

func actual_orbit_distance():
	return -body.translation.x
