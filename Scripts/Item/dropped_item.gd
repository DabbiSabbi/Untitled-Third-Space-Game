extends Node2D
@onready var itemsprite: Sprite2D = $item
@onready var shadow: Sprite2D = $shadow

var distance = 30
var item: inventoryitem
var angle = Vector2.from_angle(deg_to_rad(randi_range(0, 360)))
var curve = Vector2(-angle.y, angle.x)
var progress := 0.0:
	set(value):
		set_progress(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item:
		itemsprite.texture = item.texture
	spawn()

func spawn():
	var drop = create_tween()
	drop.tween_property(self, "progress", 1, 0.4)
	drop.tween_property(shadow, "visible", true, 0)
	drop.tween_property(itemsprite, "scale", Vector2(0.5, 0.5), 0.2)
	drop.tween_property(itemsprite, "scale", Vector2(0.6, 0.6), 0.25)
	
	

func set_progress(value: float):
	position = angle * (distance * value) + (curve * sin(PI*value)*20)
	print("pos: ", position, "     float: ", value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
