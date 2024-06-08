extends CharacterBody2D


const friction = 1

var _velocity: Vector2 = Vector2.ZERO
const max_speed: float = 6
const acceleration: float = 500

func _process(delta):
	
	_update_direction_axis_by_input(delta)


func _update_direction_axis_by_input(delta: float) -> void:
	
	var _direction_axis: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	apply_friction(friction, delta)
	
	if _direction_axis != Vector2.ZERO:
		_direction_axis = _direction_axis.normalized()
		_velocity += _direction_axis * acceleration * delta
		_velocity = _velocity.limit_length(max_speed)
		
		move_and_collide(_velocity)
		
	
	animated_sprite_2d.look_at(get_global_mouse_position())
	
		
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
			
		


@onready var camera_2d: Camera2D = $Camera2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var weapon: Weapon

func shoot():
	
 
