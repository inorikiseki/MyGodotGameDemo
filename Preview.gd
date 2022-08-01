extends TextureRect

class_name Preview

onready var label=get_node("Label")

func _ready():
	print("ready **",label)
