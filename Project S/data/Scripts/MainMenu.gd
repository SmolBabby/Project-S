extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Options").visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	#get_tree().change_scene(GlobalVar.selectedLevel)
	pass


func _on_OptionButton_pressed():
	get_node("VBoxContainer").visible = false
	get_node("Options").visible = true


func _on_QuitButton_pressed():
	get_tree().quit()
