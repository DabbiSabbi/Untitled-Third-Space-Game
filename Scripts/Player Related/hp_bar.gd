extends Control

@onready var ani: AnimatedSprite2D = $Container/AnimatedSprite2D


var player: CharacterBody2D 
var hp_frame


func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")
	


func _process(delta: float) -> void:
	hp_frame = roundi(player.hp/5)
	ani.frame = hp_frame
