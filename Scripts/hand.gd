extends Node2D
@onready var player: CharacterBody2D = $".."


# Called when the node enters the scene tree for the first time.
@onready var sprite_2d: Sprite2D = $Sprite2D
func _ready() -> void:
	pass


func fliphand():
	if position.x == 52:
		position.x = -52
	else: 
		position.x = 52

func aim():
	look_at(get_global_mouse_position())
	if player.angle >= -90 and player.angle <= 90:
		if position.x == -52:
			position.x = 52
	elif position.x == 52:
		position.x = -52

	
func _process(delta: float) -> void:
	aim()
