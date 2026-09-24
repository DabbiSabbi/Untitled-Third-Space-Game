extends CharacterBody2D
class_name enemy
var player: CharacterBody2D
@export var damage : int
@export var health : int
@export var speed : int
@export var range : int

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float) -> void:
	var target_pos = player.global_position
	if global_position.distance_to(target_pos) < range:
		target_pos = player.global_position
		velocity = Vector2.from_angle(get_angle_to(target_pos)) * global_position.distance_to(target_pos)
	elif velocity:
		velocity = velocity.move_toward(Vector2(0,0), speed * 0.3)
	
	move_and_slide()
