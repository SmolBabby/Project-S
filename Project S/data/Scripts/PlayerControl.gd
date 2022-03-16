extends KinematicBody

onready var _anim_tree = get_node("AnimationTree")

onready var camera = get_node("CameraOrbit")
onready var FPcam = get_node("CameraOrbit/FPCamera")
onready var TPcam = get_node("CameraOrbit/TPCamera")

#Mouse variables
var lookSensitivity: float = 30.0

var minLookAngle: float = -85.0
var maxLookAngle: float = 85.0

var mouseDelta: Vector2 = Vector2()

var player = self

#head movement stuff

onready var skeleton = get_node("godot_xbot/Armature/Skeleton")


#Character Variables

var runningSpeed: float = 5.0
var walkingSpeed: float = 2.0
var jumpForce: float = 4.2

var gravity: float = 9.8

var vel : Vector3 = Vector3()

puppet var repl_position = Transform()
puppet var repl_rotation = Vector3()


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#Set color to player
	var newMaterial = get_node("godot_xbot/Armature/Skeleton/Beta_Surface").mesh.surface_get_material(0)
	newMaterial.set("albedo_color", GlobalVar.current_PlayerColor)
	get_node("godot_xbot/Armature/Skeleton/Beta_Surface").mesh.surface_set_material(0, newMaterial)

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative


func _physics_process(delta):
	
	#Mouse control
	
	
	
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	
	camera.rotation_degrees.x += rot.x
	camera.rotation_degrees.y = 0
	camera.rotation_degrees.z = 0
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	player.rotation_degrees.y -= rot.y
	
	#move the head
	var headTransform = skeleton.get_bone_rest(6)
	headTransform = headTransform.rotated(Vector3(1, 0, 0), (deg2rad(rotation_degrees.x)) + 0.8)
	headTransform = headTransform.translated(Vector3(0.01, -0.08, -0.08))
	skeleton.set_bone_custom_pose(6, headTransform)
	
	
	mouseDelta = Vector2()

	
	
	if Input.is_action_just_pressed("crouch"):
		print(Gamestate.player_info)

	
	
	var root_motion: Transform = _anim_tree.get_root_motion_transform()
	
	if (is_network_master()):
		#Set camera
		TPcam.current = true
		
		vel.x = 0
		vel.z = 0
		
		var input = Vector3()
		
		if Input.is_action_pressed("move_forward"):
			input.z += 1
		if Input.is_action_pressed("move_backward"):
			input.z -= 1
		if Input.is_action_pressed("move_left"):
			input.x += 1
		if Input.is_action_pressed("move_right"):
			input.x -= 1
		
		
		
		input = input.normalized()
		
		
		
		var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
		
		if Input.is_key_pressed(KEY_SHIFT):
			vel.x = dir.x * runningSpeed
			vel.z = dir.z * runningSpeed
		else:
			vel.x = dir.x * walkingSpeed
			vel.z = dir.z * walkingSpeed
		
		
		vel.y -= gravity * delta
	
		if Input.is_action_just_pressed("jump") and is_on_floor():
			vel.y = jumpForce
			_anim_tree["parameters/playback"].travel("Jump")
		
		playAnimation(input)
		
		vel = move_and_slide(vel, Vector3.UP, true, 4, deg2rad(60))
		
		# Replicate the position
		Gamestate.player_info.anim_state = _anim_tree.get("parameters/playback")
		Gamestate.player_info.coords = Vector3(transform.origin.x, transform.origin.y, transform.origin.z)
		Gamestate.player_info.rotation = Vector3(player.rotation.x, player.rotation.y, 0)
		
		rset("repl_position", transform)
		rset("repl_rotation", rotation)
	else:
		# Take replicated variables to set current actor state
		transform = repl_position
		rotation = repl_rotation




func playAnimation(input):
	
	if Input.is_key_pressed(KEY_SHIFT):
		_anim_tree["parameters/playback"].travel("Running")
		if (input.x + input.z) == 0:
			_anim_tree["parameters/Running/playback"].travel("Idle")
			
		if input.x > 0 && input.z == 0:
			_anim_tree["parameters/Running/playback"].travel("Left")
			
		if input.x < 0 && input.z == 0:
			_anim_tree["parameters/Running/playback"].travel("Right")
			
		if input.z > 0 && input.x == 0:
			_anim_tree["parameters/Running/playback"].travel("Front")
			
		if input.z < 0 && input.x == 0:
			_anim_tree["parameters/Running/playback"].travel("Back")
			
		if input.z > 0 && input.x > 0:
			_anim_tree["parameters/Running/playback"].travel("FrontLeft")
			
		if input.z > 0 && input.x < 0:
			_anim_tree["parameters/Running/playback"].travel("FrontRight")
			
		if input.z < 0 && input.x > 0:
			_anim_tree["parameters/Running/playback"].travel("BackLeft")

			
		if input.z < 0 && input.x < 0:
			_anim_tree["parameters/Running/playback"].travel("BackRight")
	
	
	else:
		_anim_tree["parameters/playback"].travel("Walking")
		
		if (input.x + input.z) == 0:
			_anim_tree["parameters/Walking/playback"].travel("Idle")
			
		if input.x > 0 && input.z == 0:
			_anim_tree["parameters/Walking/playback"].travel("Left")
			
		if input.x < 0 && input.z == 0:
			_anim_tree["parameters/Walking/playback"].travel("Right")
			
		if input.z > 0 && input.x == 0:
			_anim_tree["parameters/Walking/playback"].travel("Front")
			
		if input.z < 0 && input.x == 0:
			_anim_tree["parameters/Walking/playback"].travel("Back")
			
		if input.z > 0 && input.x > 0:
			_anim_tree["parameters/Walking/playback"].travel("FrontLeft")
			
		if input.z > 0 && input.x < 0:
			_anim_tree["parameters/Walking/playback"].travel("FrontRight")
			
		if input.z < 0 && input.x > 0:
			_anim_tree["parameters/Walking/playback"].travel("BackLeft")
			
		if input.z < 0 && input.x < 0:
			_anim_tree["parameters/Walking/playback"].travel("BackRight")
	
	if !is_on_floor():
		_anim_tree["parameters/playback"].travel("Jump")


func playAnimationOnline(anim_name, path):
	_anim_tree[path].travel(anim_name)


func set_dominant_color(color, p):
	var newMaterial = p.mesh.surface_get_material(0)
	newMaterial.set("albedo_color", color)
	p.mesh.surface_set_material(0, newMaterial)
