extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
const BUSH_01 = preload("uid://ximmruejhlsw")
const BUSH_02 = preload("uid://bnkq7sjh7vwsa")
const BUSH_03 = preload("uid://cyohjih4cqv7k") # No berries
@onready var interact: Control = $Interact
var inrange : bool = false
var growth : int = 0
var pity : int = 1
var grown = true
var growth_timer : float
# Called when the node enters the scene tree for the first time.

func growtick():
	growth += 1
	pity = 0

func berriestex():
	if randi_range(1, 2) == 1:
		sprite_2d.texture = BUSH_01
	else:
		sprite_2d.texture = BUSH_02

func _ready() -> void:
	berriestex()
	interact.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inrange == true:
		if grown == true:
			interact.visible = true
			if Input.is_action_just_pressed("interact"):
				sprite_2d.texture = BUSH_03
				growth = 0
				grown = false
				interact.visible = false
				#player gets berries
	if grown == false:
		growth_timer += delta
		if growth_timer >= 0.5:
			growth_timer = 0
			if growth == 50:
				grown = true
				berriestex()
			if pity == 25:
				growtick()
			elif randf_range(0, 1) <= 0.1:
				growtick()
			else:
				pity += 1

func _on_xray_body_entered(body: Node2D) -> void:
	if body is player:
		sprite_2d.self_modulate.a = 0.5
func _on_xray_body_exited(body: Node2D) -> void:
	if body is player:
		sprite_2d.self_modulate.a = 1

func _on_pickup_body_entered(body: Node2D) -> void:
	if body is player:
		inrange = true
	
func _on_pickup_body_exited(body: Node2D) -> void:
	if body is player:
		inrange = false
		interact.visible = false
