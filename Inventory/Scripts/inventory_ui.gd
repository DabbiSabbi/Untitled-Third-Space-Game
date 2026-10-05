extends Control
@onready var inventory: inventory = preload("uid://v87okaswmvj8")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var grid_container: GridContainer = $NinePatchRect/GridContainer

@onready var items := inventory.items
var itemsq := {}
func _ready():
	update_slots()
	print("Items: ", items)
	for i in items:
		pass

func update_slots():
	for i in range(min(items.size(), slots.size())):
		slots[i].update(items[i])
		

func _physics_process(delta: float) -> void:
	pass

func pickup(item):
	for i in items.size():
		print("Item: ", item)
		print("slot: ", items[i])
		if items[i] == item and slots[i].quantity + 1 <= slots[i].item_resource.maxquantity:
			slots[i].stacking()
			break
		elif items[i] == null:
			print("picked up ", item)
			items[i] = item
			update_slots()
			break

func deplete(slot):
	items[slot] = null
	update_slots()
