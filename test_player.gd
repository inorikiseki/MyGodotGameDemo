extends KinematicBody2D

class_name Player

export (int) var speed=60
export (int) var acceleration =100
export (int) var jump_impulse=400
export(int) var fall_acceleration=300

var current_animation:String="idle"
var _camera_zoom=Vector2(1,1)
const AIR_FRICTION=25
const MAX_SPEED=50
const SPRINT_SPEED=100

enum {MOVE,ATTACK}
var state :=MOVE

onready var status=$PlayerStatus
onready var _animation_player=$AnimationPlayer
onready var _animated_sprite=$AnimatedSprite
onready var _camera_shake_player=$CameraShakePlayer
onready var _animation_tree=$AnimationTree
onready var _animation_state=_animation_tree.get("parameters/playback")
onready var _particle=$Particles2D
onready var  _camera=$Camera2D
onready var _arrow_pivot=$ArrowPivot

var velocity = Vector2()
var direction =Vector2()
var mouse_direction=Vector2()


func _ready():
	velocity=Vector2.ZERO
	_animation_tree	.active=true
	
func get_input(delta):
	
	direction=Vector2.ZERO
	
	direction.x=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	
	direction=direction.normalized()
	
	#mouse direction
	mouse_direction=(get_global_mouse_position()-transform.get_origin()).normalized()
	_animation_tree.set("parameters/slash/blend_position",mouse_direction.x)

	_arrow_pivot.look_at(get_global_mouse_position())
	_animation_tree.set("parameters/idle/blend_position",mouse_direction)
	_animation_tree.set("parameters/run/blend_position",mouse_direction)
			
	if direction!=Vector2.ZERO:
		
		if not Input.is_mouse_button_pressed(1):
		#Anim set
			_animation_tree.set("parameters/idle/blend_position",direction)
			_animation_tree.set("parameters/run/blend_position",direction)
		
		if Input.is_action_pressed("sprint"):
			velocity=velocity.move_toward(direction*SPRINT_SPEED,acceleration*delta)
		else:
			velocity=velocity.move_toward(direction*MAX_SPEED,acceleration*delta)
	if abs(velocity.y)>5:
		velocity=velocity.move_toward(Vector2.ZERO,AIR_FRICTION*delta)
	else:
		velocity=velocity.move_toward(Vector2.ZERO,AIR_FRICTION*2*delta)		
	velocity.y+=acceleration*delta
	
	if Input.is_action_pressed("jump"):
		velocity.y-=jump_impulse*delta
	
	#state change
	if Input.is_action_pressed("attack"):
			state=ATTACK
	velocity=move_and_slide(velocity)
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	
	#move_operates
	get_input(delta)
	
	
	#camera zoom
	
	if abs(velocity.length())>MAX_SPEED*0.5:
		pass
		
	#Anim
	match	state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
	
	#print(_animation_tree.get("parameters/slash/blend_position"))
func move_state(delta):
	
	if not velocity.is_equal_approx(Vector2.ZERO) and velocity.length()>1:
		
		_animation_state.travel("run")
		if _camera_shake_player is AnimationPlayer:
			_camera_shake_player.play("camera_shake")
	else:
		_animation_state.travel("idle")
		if _camera_shake_player is AnimationPlayer:
			_camera_shake_player.stop()
	
	if abs(velocity.y)>1 and Input.is_action_pressed("jump"):
		_particle.emitting=true
	else:
		_particle.emitting=false
		
func _process(delta):
	#camera zoom
	_camera.zoom=_camera_zoom
	if Input.is_action_pressed("camera_zoom_in"):
		_camera_zoom*=1.01
	if Input.is_action_pressed("camera_zoom_out"):
		_camera_zoom/=1.01
func attack_state(delta):
	_animation_state.travel("slash")
	
func on_attack_over():
	state=MOVE
	
func camera_zoom(delta):
	_camera.zoom=_camera.zoom.move_toward()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
