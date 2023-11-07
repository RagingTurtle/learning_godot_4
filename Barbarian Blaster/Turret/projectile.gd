extends Area3D

var direction := Vector3.FORWARD

@export var speed := 30.0

func _physics_process(delta: float) -> void:
	position += delta * direction * speed


func _on_timer_timeout() -> void:
	self.queue_free()
