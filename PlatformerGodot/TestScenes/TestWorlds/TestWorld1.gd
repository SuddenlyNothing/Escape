extends WorldBase

func load_level(lvl):
	match lvl:
		1:
			for child in $Lvl1.get_children():
				child.start()
		2:
			for child in $Lvl2.get_children():
				child.start()
			load_level(lvl-1)

func load_all_levels():
	load_level(2)
