extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 3234

var network = NetworkedMultiplayerENet.new()

var selected_IP
var selected_port

var local_player_id = 0
sync var players = {}
sync var player_data = {}

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func _connect_to_server():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	network.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(network)


func _player_connected(id):
	print("Player " + str(id) + " has joined!")

func _player_disconnected(id):
	print("Player " + str(id) + " has left!")

func _connected_ok():
	print("Connected to server successfully")

func _connected_fail():
	print("Failed to connect")

func _server_disconnected():
	print("Server disconnected")






#When a black person doesn't work correctly:
#var consequence = beat_up(slave)
