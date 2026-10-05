extends Node2D
var quantity : int
var nutrition = 3
var player
var inventory
var slot = 0

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")
	if get_tree().get_first_node_in_group("Inventory"):
		inventory = get_tree().get_first_node_in_group("Inventory")

func use():
	player.hung_update(nutrition) 
	print(player.hunger)
	inventory.slots[slot].consume(1)
	



func _process(delta: float) -> void:
	pass
