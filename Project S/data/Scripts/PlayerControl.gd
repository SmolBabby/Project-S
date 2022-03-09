extends KinematicBody

export(NodePath) var animationtree

onready var _anim_tree = get_node("AnimationTree")

onready var camera = get_node("CameraOrbit")
onready var FPcam = get_node("CameraOrbit/FPCamera")
onready var TPcam = get_node("CameraOrbit/TPCamera")

#Character Variables

var pp = GlobalVar

var runningSpeed: float = 5.0
var walkingSpeed: float = 2.0
var jumpForce: float = 4.6

var gravity: float = 9.8

var vel : Vector3 = Vector3()



func _ready():
	pass
	

func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	
	
	
	var root_motion: Transform = _anim_tree.get_root_motion_transform()
	
	
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



func playAnimation(input):
	
	#if (input.x + input.z) == 0:
		#_anim_tree["parameters/playback"].travel("Idle")
	
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
	
	#if Input.is_action_pressed("jump") and is_on_floor():
		
		
	if !is_on_floor():
		_anim_tree["parameters/playback"].travel("Jump")

