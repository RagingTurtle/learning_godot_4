extends Node3D

@export var max_health: int = 5

@onready var label_3d: Label3D = $Label3D

var current_health: int:
	get: 
		return current_health 
	set(value):
		current_health = value
		label_3d.text = str(current_health)
		if current_health < 1:
			get_tree().reload_current_scene()

func _ready() -> void:
	current_health = max_health
	
func take_damage() -> void:
	current_health -= 1
	
