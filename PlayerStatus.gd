extends Node

signal status_changed(status)

export (int) var  max_health:int =100 setget _set_max_health
export (int) var  max_mana:int =50 setget _set_max_mana
export (int) var  max_exp:int =200 setget _set_current_exp
onready var current_health:=max_health setget _set_current_health
onready var current_mana:=max_mana setget _set_current_mana
onready var current_exp:=0 setget _set_current_exp

onready var status_ui=get_tree().current_scene.get_node("CanvasLayer/PlayerStatusUI")
func _ready():
	connect("status_changed",status_ui,"on_status_changed")
	
func _set_max_health(value):
	max_health=value
	if current_health>value:
		current_health=value
	emit_signal("status_changed",self)
		
func _set_max_mana(value):
	max_mana=value
	if current_mana>value:
		current_mana=value
	emit_signal("status_changed",self)
	
func _set_current_health(value):
	current_health=value
	emit_signal("status_changed",self)
	
func _set_current_mana(value):
	current_mana=value
	emit_signal("status_changed",self)
	
func _set_current_exp(value):
	current_exp=value
	emit_signal("status_changed",self)

	
