extends CharacterBody2D
var angle = 0
const SPEED = 400

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "forward", "backward")
	if direction:
		velocity = direction * SPEED
	elif velocity.y:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	elif velocity.x:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		angle = rad_to_deg(get_angle_to(get_global_mouse_position()))
