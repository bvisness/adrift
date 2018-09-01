extends Spatial

signal killed(enemy)

onready var bulletScene = preload("res://Bullet.tscn")
onready var body = get_node("KinematicBody")

var orbitSpeed = 10
var orbitDistance = 8

var distanceLerpAmount = 1.4

func _ready():
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
	bullet.kill()
	die()

func fire():
	var bullet = bulletScene.instance()
	bullet.global_transform = body.global_transform
	get_node("/root/GameRoot/Player/Bullets").add_child(bullet)
	
func actual_orbit_distance():
	return -body.translation.x
