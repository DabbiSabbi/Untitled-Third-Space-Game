extends Node2D
class_name axe

var slot = 0
var locked = false
var target_position 
var target_rotation
@export var cd : float = 1
@export var damage : int = 1
@onready var cdt: Timer = $cd
@onready var area_2d: Area2D = $Area2D
var swing : Tween 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if locked == false:
		look_at(get_global_mouse_position())

func use():
	swing = create_tween()
	var startpos : Vector2 = position
	var startrot := rotation_degrees
	if cdt.is_stopped():
		cdt.start(cd)
		locked = true
		target_position = startpos + Vector2.from_angle(rotation) * 3
		target_rotation = startrot + 60
		swing.set_parallel(true)
		swing.set_ease(Tween.EASE_OUT)
		swing.tween_property(self, "position", target_position, 0.25)
		swing.tween_property(self, "rotation", deg_to_rad(target_rotation), 0.25)
		await swing.step_finished
		swing.set_ease(Tween.EASE_IN)
		swing.tween_property(self, "position", startpos, 0.45)
		swing.tween_property(self, "rotation", deg_to_rad(startrot), 0.45)
		await swing.finished
		locked = false
