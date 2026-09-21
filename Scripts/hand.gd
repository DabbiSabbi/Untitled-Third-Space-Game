extends Node2D
@onready var player: CharacterBody2D = $".."
@onready var cd: Timer = $"../cooldown"


# Called when the node enters the scene tree for the first time.
@onready var sprite_2d: Sprite2D = $Sprite2D
func _ready() -> void:
	pass

func aim():
	#look_at(get_global_mouse_position())
	if cd.is_stopped():
		if player.angle >= -90 and player.angle <= 90:
			if position.x == -7:
				position.x = 7
		elif position.x == 7:
			position.x = -7

	
func _process(delta: float) -> void:
	aim()
