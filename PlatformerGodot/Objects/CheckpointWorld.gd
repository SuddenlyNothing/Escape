extends Checkpoint

func save_checkpoint():
	Global.world_checkpoint.world = owner.world_num
	Global.world_checkpoint.player_pos = save_position
