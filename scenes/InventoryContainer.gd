extends ColorRect

func _process(delta):
	if Input.is_action_just_pressed("ui_inventory"):
		if visible==false:
			visible=true
			
		else:
			visible=false
		
