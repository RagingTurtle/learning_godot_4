extends CanvasLayer

@onready var star_2: TextureRect = %Star2
@onready var star_3: TextureRect = %Star3
@onready var health_label: Label = %HealthLabel
@onready var money_label: Label = %MoneyLabel

@onready var base = get_tree().get_first_node_in_group("base")
@onready var bank = get_tree().get_first_node_in_group("bank")

func victory() -> void:
	visible = true
	if base.max_health == base.current_health:
		star_2.modulate = Color.WHITE
		health_label.show()
	if bank.gold >= 500:
		star_3.modulate = Color.WHITE
		money_label.show()

func restart_game() -> void:
	get_tree().reload_current_scene()
	
func quit_game() -> void:
	get_tree().quit()
