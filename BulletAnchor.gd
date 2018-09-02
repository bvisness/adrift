extends Spatial

var bullet_ref = null

func init(bullet, shield_base):
	bullet.init_controlled(self)	
	self.translation = shield_base.to_local(bullet.global_transform.origin)
	bullet_ref = weakref(bullet)

func _process(delta):
	if bullet_ref.get_ref():
		bullet_ref.get_ref().move_to(global_transform.origin)
		pass

func release():
	if bullet_ref.get_ref():
		bullet_ref.get_ref().init_free()
		bullet_ref.get_ref().heading = self.global_transform.origin
		bullet_ref.get_ref().speed = 7
	queue_free()
	
func relinquish_bullet_control():
	queue_free()
