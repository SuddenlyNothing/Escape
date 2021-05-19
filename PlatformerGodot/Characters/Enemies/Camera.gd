extends Node2D

onready var raycast := $RayCast2D
onready var rotation_dependents := $RotationDependents

var track_player := false
var fov := 36.86989765

var player = null

func _process(delta):
	if player == null:
		player = Global.player
	if player != null:
		var visible_corners = get_player_corners_in_vision()
		for corners in visible_corners:
			if is_pos_visible(corners):
				Global.restart()

func get_player_corners_in_vision():
	var direction = Vector2.RIGHT.rotated(deg2rad(rotation_dependents.rotation_degrees))
	var visible_corners = PoolVector2Array()
	for corner in player.get_body_corners():
		var dot_product = direction.dot((corner-position).normalized())
		var angle_to_player = rad2deg(acos(dot_product))
		if angle_to_player < fov/2:
			visible_corners.append(corner)
	return visible_corners

func is_pos_visible(pos):
	raycast.cast_to = pos-position
	raycast.force_raycast_update()
	if raycast.is_colliding():
		if raycast.get_collider().name == "Player":
			return true
	return false
