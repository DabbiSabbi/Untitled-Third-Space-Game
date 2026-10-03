extends Node2D
@onready var itemsprite: Sprite2D = $item
@onready var shadow: Sprite2D = $shadow

var item: inventoryitem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item:
		itemsprite.texture = item.texture

func spawn():
	var landing = Vector2.from_angle(randi_range(0, 360))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
