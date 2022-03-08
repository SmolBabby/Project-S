extends Spatial

var lookSensitivity: float = 30.0

var minLookAngle: float = -45.0
var maxLookAngle: float = 65.0

var mouseDelta: Vector2 = Vector2()

onready var player = get_parent()

#head movement stuff

onready var skeleton = get_parent().get_node("godot_xbot/Armature/Skeleton")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

func _physics_process(delta):
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	

	rotation_degrees.x += rot.x
	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
	player.rotation_degrees.y -= rot.y

	
	#move the head
	
	var headTransform = skeleton.get_bone_rest(6)
	headTransform = headTransform.rotated(Vector3(1, 0, 0), (deg2rad(rotation_degrees.x)) + 0.8)
	headTransform = headTransform.translated(Vector3(0.01, -0.08, -0.08))
	skeleton.set_bone_custom_pose(6, headTransform)
	
	
	mouseDelta = Vector2()
	
