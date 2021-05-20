tool
extends Node2D

onready var raycast := $RayCast2D
onready var rotation_dependents := $RotationDependents
onready var static_camera := $StaticCamera

export(bool) var flip := false

var track_player := false
var fov := 36.86989765

var player = null

func _ready():
	if flip:
		flip()
		

func flip():
	if Engine.editor_hint:
		var new_rotation = 180-$RotationDependents.rotation_degrees
		$RotationDependents.rotation_degrees = new_rotation
		$StaticCamera.flip_h = !$StaticCamera.flip_h
	else:
		var new_rotation = 180-rotation_dependents.rotation_degrees
		rotation_dependents.rotation_degrees = new_rotation
		static_camera.flip_h = true

func _process(delta):
	if Engine.editor_hint:
		if flip and $StaticCamera.flip_h == false:
			flip()
		if not flip and $StaticCamera.flip_h == true:
			flip()
	else:
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
			if player.get_state() != "idle":
				return true
	return false
