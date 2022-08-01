extends Node2D

export (int) var health=100
export (int) var hit_damage=20

onready var _lifebar=$LifeBar
onready	 var _animation_player=$AnimationPlayer
func _ready():
	_lifebar.value=health
	
func _on_HurtBox_area_entered(area):
	hit_damage=rand_range(0,6)+5
	health-=hit_damage
	_lifebar.value=health
	if health>0:
		_animation_player.play("shake")
	else:
		var _Twig=load("res://scenes/effct_physic/Twig.tscn")
		var _twig=_Twig.instance()
		_twig.position=position+get_parent().position+Vector2(0,-5)
		print(position+get_parent().position)
		print(_twig.position)
		get_tree().current_scene.call_deferred("add_child",_twig)
		_animation_player.play("crash")
		
func _on_crash_anim_over():
	queue_free()
