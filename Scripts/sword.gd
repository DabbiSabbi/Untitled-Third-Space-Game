extends Node2D
class_name sword

var locked = false
var target_position 
@export var cd : float = 1
@export var damage : int = 35
@onready var cdt: Timer = $cd
@onready var area_2d: Area2D = $Area2D
var thrust : Tween 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if locked == false:
		look_at(get_global_mouse_position())


func use():
	thrust = create_tween()
	if cdt.is_stopped():
		cdt.start(cd)
		var startpos : Vector2 = position
		target_position = Vector2.from_angle(rotation) * 5
		locked = true
		#thrust.tween_property(self, "visible", true, 0)
		thrust.tween_property(area_2d, "monitoring", true, 0)
		thrust.tween_property(self, "position", target_position + startpos, 0.3)
		thrust.tween_property(self, "position", startpos, 0.1)
		thrust.tween_property(area_2d, "monitoring", false, 0)
		#thrust.tween_property(self, "visible", false, 0)
		await  thrust.finished
		locked = false
		
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is enemy:
		if thrust.is_running():
			body.hp_update(-damage)
			print("Damaged ", body.name, " for: ", damage)
			print(body.name, " hp: ", body.hp)
			await thrust.finished
