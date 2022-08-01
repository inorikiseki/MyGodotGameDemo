extends GridContainer

var inventory=preload("res://scenes/Inventory.tres")

func _ready():
	inventory.connect("items_changed",self,"_on_items_changed")
	inventory.connect("item_picked",self,"_on_item_picked")
	
	inventory.make_items_unique()
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
		print(inventory.items[item_index])
		
		
func update_inventory_slot_display(item_index):
	var inventory_slot_dispaly=get_child(item_index)
	var item=inventory.items[item_index]
	inventory_slot_dispaly.display_item(item)
	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _on_item_picked(item):
	inventory.add_item(item)
	
func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if inventory.drag_data is Dictionary:
			inventory.set_item(inventory.drag_data.item_index,\
			inventory.drag_data.item)


		
