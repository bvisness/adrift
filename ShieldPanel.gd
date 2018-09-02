extends Spatial

signal hit(entity)

onready var panel_mesh = get_node("Circle")

const normal_material = preload("res://Shield.tres")
const sticky_material = preload("res://ShieldSticky.tres")

func hit(entity):
	emit_signal("hit", entity)

func set_sticky(sticky):
	var material = sticky_material if sticky else normal_material
	panel_mesh.set_surface_material(0, material)
