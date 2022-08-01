extends KinematicBody2D

export(float) var life_time :=8
export(float) var max_speed:=100
export(float) var acceleration:=100
var velocity =Vector2()
var _mouse_position=Vector2()
onready var _timer=$Timer
onready var _animation_player=$AnimationPlayer
func _ready():
	_timer.wait_time=life_time
	_timer.start()
	_mouse_position=(get_global_mouse_position()-position).normalized()
	
	print("start pos ",position)
func _physics_process(delta):
	
	#aim at
	
	velocity=_mouse_position*max_speed
	
	velocity=move_and_slide(velocity)
func _on_Timer_timeout():
	print("runi at ",position)
	#ruin
	queue_free()

func _on_HitBox_body_entered(body):
	_animation_player.play("ruin")
	
func _on_ruin_anim_over():
	queue_free()
