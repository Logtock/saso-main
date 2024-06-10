extends Marker2D
class_name ZombieSpawner

var remaining_time : float = 10
var canspawn = false

const ZOMBIE = preload("res://Scenes/Zombie.tscn")

func _process(delta: float) -> void:
	remaining_time -= delta
	
	if remaining_time <= 0 and canspawn:
		
		var zombie = ZOMBIE.instantiate()
		get_parent().add_child(zombie)
		remaining_time = randf_range(0.5,10)
		zombie.global_position = global_position
