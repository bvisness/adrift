var enemies = []

class SavedEnemy:
	var ref
	var tag = null

func make_saved_enemy(enemy, tag = null):
	var s = SavedEnemy.new()
	s.ref = weakref(enemy)
	s.tag = tag
	return s

func add(enemy, tag = null):
	enemies.append(make_saved_enemy(enemy, tag))

func add_array(enemies, tag = null):
	for enemy in enemies:
		add(enemy, tag)

func get_valid(tag = null):
	var result = []
	for s in enemies:
		if s.ref.get_ref() and (!tag or s.tag == tag):
			result.append(s.ref.get_ref())
	
	return result
