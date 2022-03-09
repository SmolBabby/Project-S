extends Spatial

var lookSensitivity: float = 30.0

var minLookAngle: float = -60.0
var maxLookAngle: float = 85.0

var mouseDelta: Vector2 = Vector2()

onready var player = get_parent()
onready var FPcam = get_node("FPCamera")
onready var TPcam = get_node("TPCamera")

#head movement stuff

onready var skeleton = get_parent().get_node("godot_xbot/Armature/Skeleton")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	TPcam.current = true

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative



func _physics_process(delta):
	
	if Input.is_action_just_pressed("cam_switch"):
		if TPcam.current == false:
			TPcam.current = true
			player.get_node("godot_xbot/Armature/Skeleton/Beta_Surface").set("cast_shadow", 1)
			player.get_node("godot_xbot/Armature/Skeleton/Beta_Joints").set("cast_shadow", 1)
		else:
			FPcam.current = true
			player.get_node("godot_xbot/Armature/Skeleton/Beta_Surface").set("cast_shadow", 3)
			player.get_node("godot_xbot/Armature/Skeleton/Beta_Joints").set("cast_shadow", 3)
	
	#[]
	
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	
	rotation_degrees.x += rot.x
	rotation_degrees.y = 0
	rotation_degrees.z = 0
	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
	player.rotation_degrees.y -= rot.y
	
	
	
	#move the head
	var headTransform = skeleton.get_bone_rest(6)
	headTransform = headTransform.rotated(Vector3(1, 0, 0), (deg2rad(rotation_degrees.x)) + 0.8)
	headTransform = headTransform.translated(Vector3(0.01, -0.08, -0.08))
	skeleton.set_bone_custom_pose(6, headTransform)
	
	
	mouseDelta = Vector2()
