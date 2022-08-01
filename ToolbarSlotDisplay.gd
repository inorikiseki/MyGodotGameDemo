extends CenterContainer

onready var toolbar=preload("res://ToolBar.tres") 
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
	var item=toolbar.remove_item(item_index)
	if item is Item:
		var data={}
		data.item=item
		data.item_index=item_index
		
		var drag_preview=TextureRect.new()
		drag_preview.texture=item.texture
		
		set_drag_preview(drag_preview)
		toolbar.drag_data=data
		return data
	
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position, data):
	var my_item_index=get_index()
	var my_item=toolbar.items[my_item_index]
	if my_item is Item and data is Dictionary \
	and data.item.name==my_item.name \
	and my_item.is_stackable:
		my_item.amount+=data.item.amount
		toolbar.emit_signal("items_changed",[my_item_index])
	else:
		toolbar.swap_item(my_item_index,data.item_index)
		toolbar.set_item(my_item_index,data.item)
	toolbar.drag_data=null
