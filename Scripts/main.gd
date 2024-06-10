extends TileMap

class_name Map

const PLAYER = preload("res://Scenes/Player.tscn")

var peer = ENetMultiplayerPeer.new()
var pressed = false
var n_players : int = 0
var players : Array[Player] = []

func _ready() -> void:
	pass # Replace with function body.
	
func add_player(id):
	var player_character = PLAYER.instantiate()
	add_child(player_character)
	player_character.name = str(id)
	player_character.global_position = $PlayerSpawner.global_position
	player_character.global_position.x += n_players*2
	n_players += 1
	players.append(player_character)
func send_message():
	pass

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if not pressed:
			if event.is_action("F7"):
				peer.create_server(3000)
				multiplayer.multiplayer_peer = peer
				multiplayer.peer_connected.connect(add_player)
				add_player(1)
			elif event.is_action("F8"):
				peer.create_client("localhost",3000)
				multiplayer.multiplayer_peer = peer
			for node in get_children():
				if node is ZombieSpawner:
					node.canspawn = true
