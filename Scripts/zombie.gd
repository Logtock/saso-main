extends CharacterBody2D
class_name Zombie

@onready var areaZombie = $AreaZombie
@onready var attack_timeout : float = stats.attacktimeout
@export var stats : ZombieStats
@onready var timer: Timer = $Timer
@onready var health : int = stats.health
@onready var speed : int = stats.speed 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav: NavigationAgent2D = $Nav
@onready var tilemap : Map = get_parent()

var direction : Vector2
var can_attack : bool = true
var player
var navigation_timeout : float = 1
var distances_timeout : float = 0.1

func damage(_damage : int):
	
	health -= _damage	
	if health <= 0:
		
		queue_free()

func _ready() -> void:
		
	timer.wait_time = stats.attacktimeout
	
	player = get_parent().get_child(0)
	
	nav.avoidance_enabled = true

func _physics_process(delta: float) -> void:
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	if position.distance_to(player.position) > 3:
		move_and_collide(direction * speed)
		animated_sprite_2d.look_at(player.position)
	attack_timeout -= delta
	navigation_timeout -= delta
	if attack_timeout <= 0:
		attack_timeout = stats.attacktimeout
		if areaZombie.overlaps_area(player.get_node("AreaPlayer")):
			player.damage(stats.damage)
			print (player.player_health)
	if navigation_timeout < 0 : 
		nav.target_position = player.global_position
		navigation_timeout = 0.5
	distances_timeout -= delta
	if distances_timeout < 0:
		distances_timeout = 0.1
		var distances : Array[float] = []
		for player in tilemap.players:
			var distance : float = (player.position - position).length()
			distances.append(distance)
			
		distances.min
		

func _on_area_zombie_area_entered(area: Area2D) -> void:
	if area is Bullet:
		
		damage(area.damage)
		area.queue_free()
