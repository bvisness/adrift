extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const DAMAGE = 10

var speed = 4

export(SpatialMaterial) var good_material
export(SpatialMaterial) var bad_material
onready var mesh = get_node('MeshInstance')

var heading = Vector3(0, 0, 0)

enum BULLET_MODE { CONTROLLED, FREE }
var mode = FREE

func _ready():
	heading = Vector3(0, 0, 0) - self.translation
	mesh.set_surface_material(0, bad_material)

#func _process(delta):
#	pass
	
func _physics_process(delta):
	if mode == FREE:
		var collision_info = move_and_stuff(heading.normalized() * (speed * delta))

func init_controlled():
	mode = CONTROLLED

func move_to(position):
	if mode == CONTROLLED:
		heading = position - self.translation
		if get_process_delta_time():
			speed = heading.length() / get_process_delta_time()
		move_and_stuff(position - global_transform.origin)

func move_and_stuff(offset):
	var collision_info = move_and_collide(offset)
	if collision_info:
		if collision_info.collider.is_in_group('damageable'):
			collision_info.collider.hit(self)
		else:
			heading = heading.bounce(collision_info.normal)
			switch_to_good()

func switch_to_good():
	mode = FREE
	mesh.set_surface_material(0, good_material)
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, true)
	
func kill():
	queue_free()
