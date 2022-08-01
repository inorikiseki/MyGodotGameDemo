extends Area2D

var level
var exp_per_amount=5







func _on_ExpPaticle_body_entered(body):
	print("exp  **d")
	
	if body is Player:
		body.status.current_exp += exp_per_amount
	queue_free()
