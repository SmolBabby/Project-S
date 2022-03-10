extends Control

var Levels = [
	"res://data/Scenes/Levels/Testing/TestMap_FLAT.tscn",
	"res://data/Scenes/Levels/Testing/TestMap_CUBE.tscn",
]

func _ready():
	GlobalVar.selectedLevel = Levels[0]


func _process(delta):
	GlobalVar.current_PlayerColor = get_node("Settings_1/PlayerColorPicker").get("color")


func _on_LevelSelect_item_selected(index):
	GlobalVar.selectedLevel = Levels[index]


func _on_BackToMain_pressed():
	get_parent().get_node("VBoxContainer").visible = true
	visible = false


func _on_ShadowCheckButton_toggled(button_pressed):
	GlobalVar.shadows = button_pressed
