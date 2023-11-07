extends Node3D

@export var projectile: PackedScene
@export var turret_range: float = 10.0
@onready var turret_top: MeshInstance3D = $TurretBase/TurretTop
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var enemy_path: Path3D
var target: PathFollow3D

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target != null:
		look_at(target.global_position, Vector3.UP, true)
	
func _on_timer_timeout() -> void:
	if target:
		var shot: = projectile.instantiate()
		add_child(shot)
		shot.global_position = turret_top.global_position
		shot.direction = global_transform.basis.z
		animation_player.play("fire")

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if self.global_position.distance_to(enemy.global_position) <= turret_range:
				if enemy.progress > best_progress:
					best_progress = enemy.progress
					best_target = enemy
	return best_target
