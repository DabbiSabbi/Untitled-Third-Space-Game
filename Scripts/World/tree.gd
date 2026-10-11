extends Node2D
class_name tree
#script for all trees to change damage and grow time use the @exports on the scene in the inspector. NOT ON THE SCRIPT.
var item : inventoryitem = preload("uid://dx4apevx6bwcf")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var drop_yield : int 
@export var maxhp : int = 10 #hitpoints
@export var grownage : int
var growth : int = 0
var pity : int = 1
var grown := true
var growth_timer : float
var Player : player
@onready var hp := maxhp:
	set(value):
		hp = value
		if value <= 0:
			fell()

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		Player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if grown == false:
		growth_timer += delta
		if growth_timer >= 0.5:
			growth_timer = 0
			if growth >= grownage:
				grown = true
				sprite_2d.frame = 0
				areas(true)
				hp = maxhp
			if pity == 25:
				growtick()
			elif randf_range(0, 1) <= 0.1:
				growtick()
			else:
				pity += 1

func growtick():
	#why did I make a function for 2 lines that are always the same and is only called twice?
	growth += 1
	pity = 0

func _on_xray_body_entered(body: Node2D) -> void:
	if body is player:
		sprite_2d.self_modulate.a = 0.5

func _on_xray_body_exited(body: Node2D) -> void:
	if body is player:
		sprite_2d.self_modulate.a = 1

func chop(amt):
	#use a negative amt please
	hp = clampi(hp + amt, 0, maxhp)
	print("Damage taken: ", amt, " | Current hp: ", hp)

func fell():
	grown = false
	sprite_2d.frame = 1
	areas(false)
	for i in range(randi_range(1, 6)):
		# drops 1-6 berries
		var drop = preload("uid://hdt3kbyctwe4").instantiate()
		drop.item = item
		drop.angle = -(to_local(Player.global_position)).normalized()
		drop.distance = randi_range(5, 35)
		add_child(drop)

func areas(b : bool):
	#just to make my life like 2% easier(I'm a lazy fuck)
	$destruction.monitorable = b
	$xray.monitoring = b
