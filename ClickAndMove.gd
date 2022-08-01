extends Node2D

var width :int=320*4
var height :int= 180*4
var count=30
var area =Vector2(width,height)
onready	var child =$Player
func _ready():
	randomize()
	child.max_speed=5
	spawn(child,count,area)
func _unhandled_input(event):
	
	update()
func _draw():
	draw_circle(get_local_mouse_position(),60,Color(1,0,0,0.2))
	draw_circle(get_local_mouse_position(),10,Color(0,0,1,0.4))

func spawn(node2d,count,_area):
	for i in range(count):
		var position = Vector2(randi() % _area.x as int-_area.x*0.5,randi() % _area.y as int-_area.y*0.5)
		var p=child.duplicate()
		p.max_speed=rand_range(30,50)
		p.position=position
		add_child(p)
		
		
