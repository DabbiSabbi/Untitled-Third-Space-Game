extends Control
@onready var inventory: inventory = preload("uid://v87okaswmvj8")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
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
		
