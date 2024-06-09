extends Node2D


var timer : float = 1

func _process(delta):

	timer -=delta
	
	if timer <= 0:
		zombie_spawn()
		timer = 10

@onready var character_body_2d: CharacterBody2D = get_node("%Player")

@onready var tile_map: TileMap = $TileMap

const ZOMBIE = preload("res://Scenes/Zombie.tscn")

@onready var spawn_coords: Vector2=tile_map.map_to_local(Vector2i(-41,4))

func zombie_spawn():
	
	var zombie = ZOMBIE.instantiate()
	
	add_child(zombie)
	
	zombie.position = spawn_coords
	
