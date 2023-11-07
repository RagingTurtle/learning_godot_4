extends PathFollow3D

@export var speed: float = 2.5
@export var max_health: int = 50

@onready var current_health: int = max_health:
	get: 
		return current_health 
	set(value):
		current_health = value
		if current_health < 1:
			self.queue_free()
			
@onready var base = get_tree().get_first_node_in_group("base")

func _process(delta: float) -> void:
	self.progress += delta * speed
	if self.progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
