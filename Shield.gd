extends Spatial

onready var panels = [
	get_node("ShieldPanel"),
	get_node("ShieldPanel2"),
	get_node("ShieldPanel3"),
]

func connect_panel_signals(signame, receiver, method):
	for panel in panels:
		panel.connect(signame, receiver, method)

func set_sticky(sticky):
	for panel in panels:
		panel.set_sticky(sticky)
