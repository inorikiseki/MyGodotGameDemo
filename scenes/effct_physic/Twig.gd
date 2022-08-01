extends Node2D

var amount:int =1

onready var inventory=preload("res://scenes/Inventory.tres")
onready var count_label =$Count
func _ready():
	$Sprite/AnimationPlayer.play("idle")
	randomize()
	amount=rand_range(0,3)+4
	count_label.text=str(amount)

func _on_Area2D_body_entered(body):
	
	
	print(body)
	var _Twig=load("res://Resources/twig.tres")
	_Twig.amount=amount
	inventory.emit_signal("item_picked",_Twig.duplicate())
	queue_free()		
	print("twig picked")
	

func _on_Area2D_body_exited(body):
	pass # Replace with function body.
