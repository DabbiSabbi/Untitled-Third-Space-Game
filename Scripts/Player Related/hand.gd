extends Node2D
@onready var player: CharacterBody2D = $".."
var locked : bool
var current_hand : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func aim():
	#look_at(get_global_mouse_position())
	if locked == false:
		if player.angle >= -90 and player.angle <= 90:
			if position.x == -4:
				current_hand = "rh"
				scale = Vector2(1, 1)
				position.x = 4
		elif position.x == 4:
			current_hand = "lh"
			scale = Vector2(-1, 1)
			position.x = -4

	
func _process(delta: float) -> void:
	if get_child_count() > 0:
		if get_child(0) and "locked" in get_child(0):
			locked = get_child(0).locked
		aim()
