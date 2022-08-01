extends Resource

class_name Inventory

signal items_changed(indexes)
signal item_picked(item)

export (Array,Resource) var items

var drag_data=null

	
func set_item(item_index,item):
	var previous_item=items[item_index]
	items[item_index]=item
	emit_signal("items_changed",[item_index])
	return previous_item
	
func swap_item(item_index,target_item_index):
	var target_item=items[target_item_index]
	var item=items[item_index]
	items[target_item_index]=item
	items[item_index]=target_item
	emit_signal("items_changed",[item_index,target_item_index])
	
func remove_item(item_index):
	var previous_item=items[item_index]
	items[item_index]=null
	emit_signal("items_changed",[item_index])
	return previous_item

func make_items_unique():
	var unique_items=[]
	for item in items:
		if item is Item:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
		items=unique_items

func add_item(item):
	for item_index in items.size():
		
		if items[item_index] is Item:
			if items[item_index].name==item.name:
				items[item_index].amount+=item.amount
				emit_signal("items_changed",[item_index])
				break
		elif items[item_index]==null:
			set_item(item_index,item)
			break
		else:
			print("FULL INVENTORY")
	print("add item***********")
	

	
