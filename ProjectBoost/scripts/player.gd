extends RigidBody3D

## Thrust force applied when boosting or moving forward.
@export_range(750.0, 3000) var thrust_force: float = 1000

## Torque applied for rotation or turning left/right.
@export_range(75.0, 300) var rotation_torque: float = 100

@onready var death_audio: AudioStreamPlayer = $DeathAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio_3d: AudioStreamPlayer3D = $RocketAudio3D
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles

var is_tweening: bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust_force)
		booster_particles.emitting = true
		if rocket_audio_3d.stream_paused:
			rocket_audio_3d.stream_paused = false
		if !rocket_audio_3d.playing:  
			rocket_audio_3d.play()
	else:
		booster_particles.emitting = false
		if rocket_audio_3d.playing: 
			rocket_audio_3d.stream_paused = true
		
	if Input.is_action_pressed("turn_left"):
		apply_torque(Vector3(0, 0, rotation_torque) * delta)
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false
		
	if Input.is_action_pressed("turn_right"):
		apply_torque(Vector3(0, 0, -rotation_torque) * delta)
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false

func _on_body_entered(body: Node) -> void:
	if !is_tweening:
		if "goal" in body.get_groups():
			complete_level(body.file_path)
			
		if "hazard" in body.get_parent().get_groups():
			crash_sequence()

func crash_sequence() -> void:
	death_audio.play()
	explosion_particles.emitting = true
	booster_particles.emitting = false
	if rocket_audio_3d.playing: 
		rocket_audio_3d.stop()
	set_physics_process(false)
	is_tweening = true
	var tween = create_tween()
	var tween_delay = max(death_audio.stream.get_length() - death_audio.get_playback_position(), explosion_particles.lifetime / explosion_particles.process_material.initial_velocity_max)
	tween.tween_interval(tween_delay)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(next_scene_filepath: String) -> void:
	success_audio.play()#("WIN!")
	success_particles.emitting = true
	booster_particles.emitting = false
	if rocket_audio_3d.playing: 
		rocket_audio_3d.stop()
	set_physics_process(false)
	is_tweening = true
	var tween = create_tween()
	var tween_delay = max(success_audio.stream.get_length() - death_audio.get_playback_position(), success_particles.lifetime/ success_particles.process_material.initial_velocity_max)
	tween.tween_interval(tween_delay)
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_scene_filepath))
