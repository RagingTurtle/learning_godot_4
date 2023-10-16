extends RigidBody3D

## Thrust force applied when boosting or moving forward.
@export_range(750.0, 3000) var _thrustForce: float = 1000

## Torque applied for rotation or turning left/right.
@export_range(75.0, 300) var _rotationTorque: float = 100

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * _thrustForce)
		
	if Input.is_action_pressed("turn_left"):
		apply_torque(Vector3(0, 0, _rotationTorque) * delta)
		
	if Input.is_action_pressed("turn_right"):
		apply_torque(Vector3(0, 0, -_rotationTorque) * delta)

func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		complete_level()
		
	if "Ground" in body.get_groups():
		crash_sequence()

func crash_sequence() -> void:
	print("BOOM!")
	get_tree().reload_current_scene()
	
func complete_level() -> void:
	print("WIN!")
	get_tree().quit()
