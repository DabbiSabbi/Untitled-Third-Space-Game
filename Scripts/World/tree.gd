extends Node2D
#script for all trees to change damage and grow time use the @exports on the scene in the inspector. NOT ON THE SCRIPT.
class_name tree
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var drop_yield : int 
@export var maxhp : int = 10 #hitpoints
@export var grownage : int
var growth : int = 0
var pity : int = 1
var grown := true
var growth_timer : float
@onready var hp := maxhp:
	set(value):
		hp = value
		if value <= 0:
			fell()

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

func areas(b : bool):
	#just to make my life like 2% easier(I'm a lazy fuck)
	$destruction.monitorable = b
	$xray.monitoring = b
