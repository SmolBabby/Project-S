extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://data/Scenes/Levels/Testing/TestMap_FLAT.tscn")


func _on_OptionButton_pressed():
	get_tree().change_scene("res://data/Scenes/HUD/Main_Menu/OptionsMenu.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()