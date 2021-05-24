extends WorldBase

func load_level(lvl):
	match lvl:
		1:
			for child in $Level1.get_children():
				child.start()
		2:
			for child in $Level2.get_children():
				child.start()
			load_level(lvl-1)
		3:
			for child in $Level3.get_children():
				child.start()
			load_level(lvl-1)

func load_all_levels():
	load_level(3)
