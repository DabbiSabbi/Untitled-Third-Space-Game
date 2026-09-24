extends Control

@onready var inventory: inventory = preload("uid://v87okaswmvj8") 
# uid for playerinventory.tres
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update_slots()

func update_slots():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
		
