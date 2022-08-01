extends KinematicBody2D

enum {IDLE,PATROL,ATTACK,HIT}

var health=60
var state:=IDLE
const MAX_SPEED =30
const ACCELERATION=50
const JUMP_FORCE =60
const FALL_ACCELERATION=50
const FRICTION=40
var hit_strength=40
var hit_direction=Vector2.ZERO
var feedback=Vector2.ZERO
var velocity=Vector2.ZERO

var target

var exp_drop=preload("res://ExpPaticle.tscn")
onready var _hurt_box =$HurtBox
onready var _paritcle=$Particles2D
onready var _animation_player=$AnimationPlayer

func _ready():
	state=IDLE
	
func _physics_process(delta):
	
	match state:
		IDLE: 
			feedback=feedback.move_toward(Vector2.ZERO,FRICTION*delta)
			feedback.y+=FALL_ACCELERATION*delta	
			feedback=move_and_slide(feedback)
		PATROL:
			patorl_state(delta)
		ATTACK:
			attack_state(delta)

func _on_HurtBox_area_entered(area):
	state=IDLE
	print("enter **")
	hit_direction=(position-area.get_parent().position).normalized()

	print(hit_direction)
	feedback=hit_direction*hit_strength
	print(hit_direction)
	health-=rand_range(0,15)+15
	if health>0:
		_animation_player.play("splash")
	elif health<=0:
		_animation_player.play("die")

func on_die_over():
	var exp_drop_instance=exp_drop.instance()
	exp_drop_instance.global_position=global_position
	get_tree().current_scene.call_deferred("add_child",exp_drop_instance)
	queue_free()
	
func patorl_state(delta):
	velocity=velocity.move_toward(MAX_SPEED* \
	(target.global_position-global_position).normalized() \
	,ACCELERATION*delta)
	velocity=move_and_slide(velocity)
	
func attack_state(delta):
	pass

func has_target():
	return not (target == null)


func _on_Detection_body_entered(body):
	target=body
	state=PATROL

func _on_Detection_body_exited(body):
	target=null
	state=IDLE
