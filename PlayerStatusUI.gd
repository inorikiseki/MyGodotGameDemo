extends Control

class_name PlayerStatusUI

onready var player_status=get_tree().current_scene.get_node("Player/PlayerStatus")
onready var health_bar=$HealthBar
onready var mana_bar=$ManaBar
onready var exp_bar=$ExpBar

func _ready():
	
	player_status.emit_signal("status_changed",player_status)
func on_status_changed(status):
	health_bar.max_value=status.max_health
	health_bar.value=status.current_health
	mana_bar.max_value=status.max_mana
	mana_bar.value=status.current_mana
	exp_bar.value=status.current_exp
	
