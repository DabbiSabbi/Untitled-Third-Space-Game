extends CharacterBody2D
class_name player
var angle = 0
const SPEED = 80
@export var maxhp = 100
var hp = maxhp
var hunger = 20
#This is for the player inventory (hotbar)
@export var inventory: inventory 
@onready var hand: Node2D = $Hand
@onready var hunger_loss: Timer = $hunger_loss
@onready var ani: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "forward", "backward")
	if direction:
		velocity = direction * SPEED
	elif velocity.y:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	elif velocity.x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction == Vector2(0,-1):
		ani.play("forward")
	else: 
		ani.play("idle")
	move_and_slide()
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		angle = rad_to_deg(get_angle_to(get_global_mouse_position()))
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if hand.get_child(0):
				if hand.get_child(0).has_method("use"):
					hand.get_child(0).use()

func held_item(scene, slot):
	print(scene)
	print(hand.get_children())
	if scene == null and hand.get_child_count() > 0:
		hand.get_child(0).queue_free()
	elif hand.get_child_count() > 0:
		hand.get_child(0).queue_free()
	if scene:
		var item = scene.instantiate()
		await get_tree().physics_frame
		hand.add_child(item)
		hand.get_child(0).slot = slot

func hp_update(amt):
#	Use For Healing and Damage
	hp = clampi(hp + amt, 0, maxhp) 
	if hp == 0:
		pass

func hung_update(amt):
#	Used For Hunger
	hunger = clampi(hunger + amt, 0, 20) 
	if hunger == 0:
		print("You are Starving!")
	if hunger == 20:
		print("You are Full!")

func _on_hunger_loss_timeout() -> void:
	hung_update(-1)
	print(hunger)
