extends Spatial


onready var player = get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass 


func _process(delta):
	if player.transform.origin.y < -50:
		player.transform.origin = Vector3(0, 5, 0)
	$Light.shadow_enabled = GlobalVar.shadows
