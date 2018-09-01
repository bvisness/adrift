extends Spatial

func finish():
	pass

func is_finished():
	print("WARNING! You didn't override the is_finished method on Wave.")
	return false
