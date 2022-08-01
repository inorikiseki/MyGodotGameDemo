extends CenterContainer

onready var inventory=preload("res://scenes/Inventory.tres") 
onready var item_textureRect=$TextureItem
onready var item_amount_label=$TextureItem/Label

func display_item(item):
	if item is Item:
		item_textureRect.texture=item.texture
		if item.is_stackable:
			item_amount_label.text=str(item.amount)
		else:
			item_amount_label.text=""
	else:
		item_textureRect.texture=load("res://Assets/sprites/Items/slot_empty.png")
		item_amount_label.text=""
		
func get_drag_data(_position):
	var item_index=get_index()
	var item=inventory.remove_item(item_index)
	if item is Item:
		var data={}
		data.item=item
		data.item_index=item_index
		
		var drag_preview=TextureRect.new()
		drag_preview.texture=item.texture
		
		set_drag_preview(drag_preview)
		inventory.drag_data=data
		return data
	
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position, data):
	var my_item_index=get_index()
	var my_item=inventory.items[my_item_index]
	if my_item is Item and data is Dictionary \
	and data.item.name==my_item.name \
	and my_item.is_stackable:
		my_item.amount+=data.item.amount
		inventory.emit_signal("items_changed",[my_item_index])
	else:
		inventory.swap_item(my_item_index,data.item_index)
		inventory.set_item(my_item_index,data.item)
	inventory.drag_data=null
