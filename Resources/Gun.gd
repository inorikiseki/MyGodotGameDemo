extends Node2D

onready var _bullet =preload("res://Resources/Bullet.tscn")
onready var _timer =$Timer
onready var _muzzle=$Muzzle
onready var gun_sprite=$Sprite
onready var amount_label=$CanvasLayer/Label

export (bool) var equipped: =false setget _set_equipped,_get_equipped
export (float) var shoot_interval:=0.1
export (int) var bullet_max_amount:=400
export (int) var bullet_remain_amount:=bullet_max_amount

func _ready():
	
	_timer.stop()
	
	
func _process(delta):
	print(scale)
	if(Input.is_action_just_pressed("equip_slot01")):
		 equipped= not equipped
	match equipped:
		true:
			amount_label.text=str(bullet_remain_amount)+"/"+str(bullet_max_amount)
			equip_state(delta)
		false:
			amount_label.text=""
			pass
	visible=equipped
func equip_state(delta):
	if (get_global_mouse_position()-position).x<0:
		gun_sprite.flip_v=true
	else:
		gun_sprite.flip_v=false
		
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("attack"):
		shoot()
		_timer.start()
	if Input.is_action_just_released("attack"):
		_timer.stop()
		
		
func _on_Timer_timeout():
	
	shoot()
	
func shoot():
	print("shoot")
	if bullet_remain_amount>0:
		bullet_remain_amount-=1;
		amount_label.text=str(bullet_remain_amount)+"/"+str(bullet_max_amount)
		var bullet_instance=_bullet.instance()
		
		#bullet_instance.position+=_muzzle.get_global_transform().get_origin()
		#get_tree().current_scene.add_child(bullet_instance.duplicate())
		bullet_instance.transform=_muzzle.get_global_transform()
		get_tree().current_scene.add_child(bullet_instance.duplicate())
func _set_equipped(is_equip):
	equipped=is_equip
	
		
func _get_equipped():
	pass
