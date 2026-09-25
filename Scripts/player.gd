extends CharacterBody2D
class_name player
var angle = 0
const SPEED = 100
#This is for the player inventory (hotbar)
@export var inventory: inventory 

@onready var hand: Node2D = $Hand

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "forward", "backward")
	if direction:
		velocity = direction * SPEED
	elif velocity.y:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	elif velocity.x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		angle = rad_to_deg(get_angle_to(get_global_mouse_position()))
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if hand.get_child(0):
				if hand.get_child(0).has_method("use"):
					hand.get_child(0).use()
