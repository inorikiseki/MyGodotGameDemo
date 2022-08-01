extends KinematicBody2D

export(float) var max_speed:=100
export(float) var acceleration:=100
export(float) var friction=50

var velocity =Vector2.ZERO
var target =Vector2()
var dircetion=Vector2()
func _ready():
	pass
func _process(delta):
	update()
func _physics_process(delta):
	
	if (target-position).length()<60:
		velocity=velocity.move_toward(Vector2.ZERO,friction*delta)
	else:
		velocity=velocity.move_toward(Vector2(1,0)*max_speed,acceleration*delta)
	position=position.move_toward(target,velocity.length()*delta)
	#velocity=move_and_slide(velocity)
func _unhandled_input(event):
	if event is InputEventMouse:
		target=get_global_mouse_position()
		dircetion = (target-position).normalized()
		
func _draw():
	var step = sqrt(velocity.length())
	draw_line(Vector2.ZERO,Vector2.ZERO-dircetion*step,Color(1,0,0,1),2.0,false)
	draw_circle(Vector2.ZERO-dircetion*step,3,Color(1,1,0,1))
