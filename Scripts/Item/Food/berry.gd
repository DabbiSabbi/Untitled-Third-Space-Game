extends Node2D
var quantity : int
var player

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")

func use():
	player.hung_update(3) 
	print(player.hunger)



func _process(delta: float) -> void:
	pass
