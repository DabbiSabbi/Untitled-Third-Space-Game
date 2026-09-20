extends Node2D
var locked = false
var target_position 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !locked:
		look_at(get_global_mouse_position())


func use():
	target_position = Vector2.from_angle(rotation) * 30
	var thrust = create_tween()
	thrust.tween_property(self, "visible", true, 0)
	thrust.tween_property(self, "position", target_position, 0.35)
	
	
	
