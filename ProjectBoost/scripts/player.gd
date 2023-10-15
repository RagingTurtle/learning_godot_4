extends RigidBody3D

@export var force_magnitude :float = 1000
@export var torgue_magnitude : float = 100

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_pressed("ui_accept"):
		apply_central_force(basis.y * delta * force_magnitude)
		
	if Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0, 0, torgue_magnitude) * delta)
		
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0, 0, -torgue_magnitude) * delta)
