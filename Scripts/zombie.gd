extends CharacterBody2D

@export var stats : ZombieStats

@onready var timer: Timer = $Timer

var direction : Vector2

@onready var health : int = stats.health
@onready var speed : int = stats.speed 

var can_attack : bool = true

func _ready() -> void:
	
	timer.wait_time = stats.attacktimeout
	
	player = get_parent().get_child(0)

var player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	direction = (player.position - position).normalized()
	
	if position.distance_to(player.position) > 3:
		move_and_collide(direction * speed)
		animated_sprite_2d.look_at(player.position)
		

	timeout -= delta
	
	if timeout <= 0:
		
		timeout = stats.attacktimeout
		
		if areaZombie.overlaps_area(player.get_node("AreaPlayer")):
			
			player.damage(stats.damage)
			print (player.player_health)
	

@onready var areaZombie = $AreaZombie

@onready var timeout : float = stats.attacktimeout
