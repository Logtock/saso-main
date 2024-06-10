extends Area2D
class_name Bullet

var speed : float = 1
var damage : int = 1

func _physics_process(delta: float) -> void:
	
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	
	if not body is Zombie:
		queue_free()
