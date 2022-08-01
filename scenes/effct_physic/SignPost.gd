extends Node2D

onready var _place_name_label=$PlaceName

func _ready():
	_place_name_label.text=""
	
func _on_Area2D_area_entered(area):
	_place_name_label.text="Start Place"


func _on_Area2D_body_entered(body):
	_place_name_label.text="Start Place"


func _on_Area2D_body_exited(body):
	_place_name_label.text=""
