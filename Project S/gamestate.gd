extends Node


var player_info = {
	name = "Player",                               # How this player will be shown within the GUI
	net_id = 1,                                    # By default everyone receives "server ID"
	actor_path = "res://data/Scenes/Player.tscn",  # The class used to represent the player in the game world
	char_color = Color(1, 1, 1),                   # By default don't modulate the icon color
	coords = Vector3(),
	rotation = Vector3(),
	anim_state = {anim_name = "String", anim_path = "String"}
}
