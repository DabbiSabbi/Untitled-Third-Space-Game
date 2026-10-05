extends Node2D
var quantity : int
var nutrition = 3
var health = 5
var player

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")

func use():
	player.hung_update(3) 
	print(player.hunger)
	inventory.slots[slot].consume(1)
	player.hp_update(health)
	



func _process(delta: float) -> void:
	pass
