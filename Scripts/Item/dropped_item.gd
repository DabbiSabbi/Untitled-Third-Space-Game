extends Node2D
@onready var itemsprite: Sprite2D = $item
@onready var shadow: Sprite2D = $shadow
@onready var interact: Control = $Interact

var inrange : bool = false
var distance
var item: inventoryitem
var angle
var curve : Vector2
var docurve = false
var progress := 0.0:
	set(value):
		set_progress(value)
var inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().get_first_node_in_group("Inventory"):
		inventory = get_tree().get_first_node_in_group("Inventory")
	if item:
		itemsprite.texture = item.texture
	spawn()

func spawn():
	var drop = create_tween()
	if docurve == true:
		curve = Vector2(-angle.y, angle.x)
		drop.tween_property(self, "progress", 1, 0.4)
	else:
		drop.tween_property(self, "position", angle * distance, 0.4)
	drop.tween_property(shadow, "visible", true, 0)
	drop.tween_property(itemsprite, "scale", Vector2(0.5, 0.5), 0.2)
	drop.tween_property(itemsprite, "scale", Vector2(0.6, 0.6), 0.25)
	
	

func set_progress(value: float):
	if docurve == true:
		position = angle * (distance * value) + (curve * sin(PI*value)*20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inrange == true:
		if Input.is_action_just_pressed("pickup"):
			inventory.pickup(item)
			queue_free()

func _on_pickup_body_entered(body: Node2D) -> void:
	if body is player:
		interact.visible = true
		inrange = true


func _on_pickup_body_exited(body: Node2D) -> void:
		if body is player:
			interact.visible = false
			inrange = false
			
