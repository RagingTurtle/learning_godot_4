extends PathFollow3D

@export var speed: float = 2.5

@onready var base = get_tree().get_first_node_in_group("base")

func _process(delta: float) -> void:
	self.progress += delta * speed
	if self.progress_ratio == 1.0:
		base.take_damage()
