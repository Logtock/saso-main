extends Resource
class_name Weapon

@export_range(0,1000) var damage: float = 10
@export var name: StringName
@export_range(0.0001,100000) var rpm: float = 0.1
@export_range(1,10000) var capacity: int = 12
@export var max_distance: float = 1000
@export var damage_area: float = 10  
var current_capacity: int = capacity
@export var velocity : int = 10
