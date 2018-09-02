extends CanvasItem

const SyncStopwatch = preload("res://Timing.gd").SyncStopwatch
var stopwatch = SyncStopwatch.new()

var fade_active = false
var duration = 1
var start_alpha = 0
var target_alpha = 1

func set_alpha(alpha):
	fade_active = false
	modulate.a = alpha
	stopwatch.stop()

func fade(duration, alpha = 1):
	self.duration = duration
	self.fade_active = true
	self.start_alpha = modulate.a
	self.target_alpha = alpha
	stopwatch.reset()
	stopwatch.start()

func _process(delta):
	stopwatch.process(delta)
	
	if fade_active:
		modulate.a = lerp(start_alpha, target_alpha, clamp(stopwatch.time / duration, 0, 1))
	
	if stopwatch.time > duration:
		fade_active = false
		stopwatch.stop()
