extends CharacterBody2D

class_name Player

@onready var player: CharacterBody2D = %Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var weapon: Weapon

const bullet_instance = preload("res://Scenes/Bullet.tscn")
const friction = 1
var _velocity: Vector2 = Vector2.ZERO
const max_speed: float = 6
const acceleration: float = 500
var player_health : int = 1000
var aim_direction : Vector2
var shooting : bool

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _process(delta):
	_update_direction_axis_by_input(delta)
	if player_health <= 0 :
		queue_free()

func _update_direction_axis_by_input(delta: float) -> void:
	var _direction_axis: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	apply_friction(friction, delta)
	
	if _direction_axis != Vector2.ZERO:
		_direction_axis = _direction_axis.normalized()
		_velocity += _direction_axis * acceleration * delta
		_velocity = _velocity.limit_length(max_speed)
		move_and_collide(_velocity)
	
	self.look_at(get_global_mouse_position())
	
	aim_direction = (get_global_mouse_position()-position).normalized()

func apply_friction(amount: float, delta: float):
	_velocity = _velocity.move_toward(Vector2.ZERO, amount * delta)

func _input(event: InputEvent):
	
	if(event.is_pressed()):
		if event is InputEventMouseButton:
			if event.is_action("wheel_down"):
				camera_2d.zoom *= 0.95
			if event.is_action("wheel_up"):
				camera_2d.zoom *= 1.05
			camera_2d.zoom=camera_2d.zoom.clamp(Vector2(0.8,0.8),Vector2(2,2))
			if event.is_action("left_click"):
				shoot()
	if event.is_action_released("left_click"):
		shooting = false

func shoot():
	
	shooting = true
	
	while shooting:
		var bullet : Bullet = bullet_instance.instantiate()
		
		get_parent().add_child(bullet)
		
		bullet.transform = $Marker2D.global_transform
		bullet.speed = weapon.velocity
		bullet.damage = weapon.damage
		
		await get_tree().create_timer(weapon.rpm).timeout
 
func damage(_damage:int):
	
	player_health -= _damage
