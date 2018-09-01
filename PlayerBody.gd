extends KinematicBody

func hit(entity):
	get_parent().hit(entity)
