extends RigidBody3D

## Thrust force applied when boosting or moving forward.
@export_range(750.0, 3000) var thrust_force: float = 1000

## Torque applied for rotation or turning left/right.
@export_range(75.0, 300) var rotation_torque: float = 100

## Delay for tweening in seconds
@export_range(0, 5) var tween_delay: float = 1

var is_tweening: bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust_force)
		
	if Input.is_action_pressed("turn_left"):
		apply_torque(Vector3(0, 0, rotation_torque) * delta)
		
	if Input.is_action_pressed("turn_right"):
		apply_torque(Vector3(0, 0, -rotation_torque) * delta)

func _on_body_entered(body: Node) -> void:
	if !is_tweening:
		if "Goal" in body.get_groups():
			complete_level(body.file_path)
			
		if "Ground" in body.get_groups():
			crash_sequence()

func crash_sequence() -> void:
	print("BOOM!")
	
	set_physics_process(false)
	is_tweening = true
	var tween = create_tween()
	tween.tween_interval(tween_delay)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_scene_filepath: String) -> void:
	print("WIN!")
	
	set_physics_process(false)
	is_tweening = true
	var tween = create_tween()
	tween.tween_interval(tween_delay)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_scene_filepath))
