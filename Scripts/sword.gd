extends Node2D

var locked = false
var target_position 
@export var cd : float = 1
@onready var cdt: Timer = $cd


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if locked == false:
		look_at(get_global_mouse_position())


func use():
	
	if cdt.is_stopped():
		cdt.start(cd)
		var startpos : Vector2 = position
		target_position = Vector2.from_angle(rotation) * 5
		var thrust = create_tween()
		locked = true
		#thrust.tween_property(self, "visible", true, 0)
		thrust.tween_property(self, "position", target_position + startpos, 0.3)
		thrust.tween_property(self, "position", startpos, 0.1)
		#thrust.tween_property(self, "visible", false, 0)
		await  thrust.finished
		locked = false
		
	
