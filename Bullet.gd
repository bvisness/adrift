extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const DAMAGE = 10

var speed = 4

export(SpatialMaterial) var enemy_material
export(SpatialMaterial) var player_material
onready var mesh = get_node('MeshInstance')

var heading = Vector3(0, 0, 0)

enum BULLET_MODE { CONTROLLED, FREE }
var mode = FREE
var controller = null

enum BULLET_ALLEGIANCE { ENEMY, PLAYER, NEUTRAL }
var allegiance = ENEMY

func _ready():
	heading = Vector3(0, 0, 0) - self.translation
	mesh.set_surface_material(0, enemy_material)

#func _process(delta):
#	pass
	
func _physics_process(delta):
	if mode == FREE:
		var collision_info = move_and_stuff(heading.normalized() * (speed * delta))

func init_controlled(new_controller):
	if controller and controller.get_ref():
		controller.get_ref().relinquish_bullet_control()
	
	controller = weakref(new_controller)
	mode = CONTROLLED

func init_free():
	if controller and controller.get_ref():
		controller.get_ref().relinquish_bullet_control()
	mode = FREE

func move_to(position):
	if mode == CONTROLLED:
		heading = position - self.translation
		if get_process_delta_time():
			speed = heading.length() / get_process_delta_time()
		move_and_stuff(position - global_transform.origin)

func move_and_stuff(offset):
	var collision_info = move_and_collide(offset)
	if collision_info:
		if collision_info.collider.is_in_group('bullet_can_hit'):
			if collision_info.collider.is_in_group('bullet_bounce'):
				heading = heading.bounce(collision_info.normal)
				set_allegiance(PLAYER)
				mode = FREE
			collision_info.collider.hit(self)
	
func set_allegiance(allegiance):
	match allegiance:
		ENEMY:
			mesh.set_surface_material(0, enemy_material)
			set_collision_mask_bit(0, true)
			set_collision_mask_bit(1, false)
		PLAYER:
			mesh.set_surface_material(0, player_material)
			set_collision_mask_bit(0, false)
			set_collision_mask_bit(1, true)
		NEUTRAL:
			set_collision_mask_bit(0, false)
			set_collision_mask_bit(1, false)
		_:
			print("WARNING! Unrecognized allegiance for bullet: " + str(allegiance))
	
func kill():
	queue_free()
