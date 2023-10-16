extends RigidBody3D

@export var force_magnitude :float = 1000
@export var torgue_magnitude : float = 100

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * force_magnitude)
		
	if Input.is_action_pressed("turn_left"):
		apply_torque(Vector3(0, 0, torgue_magnitude) * delta)
		
	if Input.is_action_pressed("turn_right"):
		apply_torque(Vector3(0, 0, -torgue_magnitude) * delta)

func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		print("WIN")
		
	if "Ground" in body.get_groups():
		print("LOSE")
