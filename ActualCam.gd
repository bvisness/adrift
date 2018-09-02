extends Camera

var target_cam = null

const lerp_speed = 1.5

func _process(delta):
	if target_cam:
		translation = translation.linear_interpolate(target_cam.translation, lerp_speed * delta)
		transform.basis = Basis(Quat(transform.basis).slerp(Quat(target_cam.transform.basis), lerp_speed * delta))
		fov = lerp(fov, target_cam.fov, lerp_speed * delta)

func snap_to_cam(cam):
	target_cam = null
	transform = cam.transform
	fov = cam.fov

func lerp_to_cam(cam):
	target_cam = cam
