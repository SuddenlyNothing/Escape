tool
extends Node2D
class_name StaticCamera

onready var raycast := $RayCast2D
onready var rotation_dependents := $RotationDependents
onready var static_camera := $StaticCamera

export(int, -360, 360) var rot_deg := 45

var track_player := false
var fov := 36.86989765

var player = null

func _ready():
	set_rot_deg()

func set_rot_deg():
	if Engine.editor_hint:
		$RotationDependents.rotation_degrees = rot_deg
		if rot_deg > 90 and rot_deg < 270:
			$StaticCamera.scale.x = -1
		else:
			$StaticCamera.scale.x = 1
	else:
		rotation_dependents.rotation_degrees = rot_deg
		if rot_deg > 90 and rot_deg < 270:
			static_camera.scale.x = -1
		else:
			static_camera.scale.x = 1

func _process(delta):
	if Engine.editor_hint:
		set_rot_deg()
	else:
		if player == null:
			player = Global.player
		if is_player_in_vision():
			Global.restart()

func is_player_in_vision():
	if player == null:
		return
	var visible_corners = get_player_corners_in_vision()
	for corners in visible_corners:
		if is_pos_visible(corners):
			return true
	return false

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
#		print(raycast.get_collider().name)
		if raycast.get_collider().name == "Player":
			if player.get_state() != "idle":
				return true
	return false
