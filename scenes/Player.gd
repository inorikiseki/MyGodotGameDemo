extends KinematicBody2D

export (int) var speed=60
export (int) var acceleration =200
export (int) var jump_impulse=10
export(int) var fall_acceleration=300

var current_animation:String="idle"

const FRICTION=100
const MAX_SPEED=100
const SPRINT_SPEED=150

onready var _animation_player=$AnimationPlayer
onready var _animated_sprite=$AnimatedSprite
onready var _camera_shake_player=$CameraShakePlayer

var velocity = Vector2()
var direction =Vector2()

func _ready():
	velocity=Vector2.ZERO
func get_input(delta):
	
	direction=Vector2.ZERO
	
	direction.x=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	direction.y=Input.get_action_strength("move_forward")-Input.get_action_strength("move_back")
	
	direction=direction.normalized()
	
	if direction!=Vector2.ZERO:
		if Input.is_action_pressed("sprint"):
			velocity=velocity.move_toward(direction*SPRINT_SPEED,acceleration*delta)
		else:
			velocity=velocity.move_toward(direction*MAX_SPEED,acceleration*delta)
	else:	
		velocity=velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	
	velocity.y+=acceleration*delta
	
	if Input.is_action_pressed("jump"):
		velocity.y-=jump_impulse
		
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	
	get_input(delta)
	
	velocity=move_and_slide(velocity)
	
	if velocity!=Vector2.ZERO:
		_animated_sprite.play("run")
		_animation_player.play("run")
		if _camera_shake_player is AnimationPlayer:
			_camera_shake_player.play("camera_shake")
		if velocity.x>0:
			_animated_sprite.flip_h=false
		elif velocity.x<0:
			_animated_sprite.flip_h=true
	else:
		_animated_sprite.stop()
		_animation_player.play("idle")
		if _camera_shake_player is AnimationPlayer:
			_camera_shake_player.stop()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
