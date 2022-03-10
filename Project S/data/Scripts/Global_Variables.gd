extends Node


#Red, Green, Blue
var current_PlayerColor:Color
var selectedLevel:String

var shadows:bool = true


func _ready():
	selectedLevel = "res://data/Scenes/Levels/Testing/TestMap_FLAT.tscn"
