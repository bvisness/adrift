extends Object

class SyncStopwatch:
	var is_running = false
	var time = 0
	
	func start():
		is_running = true
	
	func stop():
		is_running = false
	
	func process(delta):
		if is_running:
			time += delta
	
	func reset(overflow_value = null):
		if overflow_value:
			time = time - overflow_value
		else:
			time = 0
