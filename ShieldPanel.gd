extends Spatial

signal hit(entity)

func hit(entity):
	emit_signal("hit", entity)
