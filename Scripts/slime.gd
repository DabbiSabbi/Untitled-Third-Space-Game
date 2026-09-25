extends CharacterBody2D
class_name enemy
var player: CharacterBody2D
@onready var attack_area: Area2D = $AttackArea
@onready var ani: AnimatedSprite2D = $AnimatedSprite2D
@onready var cdt: Timer = $cdt
var inrange : bool
var attacking : bool
@export var damage : int # attack damage. 
@export var health : int # do you really need me to explain this one? 
@export var speed : int # walk speed.
@export var range : int # range for enemy to attack player in pixels.
@export var cd : int # attack cooldown in seconds always less than attack animation time.

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta: float) -> void:
	var target_pos = player.global_position
	if global_position.distance_to(target_pos) < range:
		ani.speed_scale = 1.75
		target_pos = player.global_position
		velocity = Vector2.from_angle(get_angle_to(target_pos)) * global_position.distance_to(target_pos)
	elif velocity:
		velocity = velocity.move_toward(Vector2(0,0), speed * 0.3)
		ani.speed_scale = 1
	if !cdt.is_stopped():
		print(cdt.time_left)
	move_and_slide()

func attack():
	attacking = true
	while inrange:
		cdt.start(cd)
		ani.play("green-uni-attack")
		while ani.frame != 3:
			await ani.frame_changed
		if inrange:
			player.hp_update(-damage)
		await ani.animation_finished
		ani.animation = "green-idle&walk"
		await cdt.timeout
		print("Timer done")
	attacking = false

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body == player:
		if !attacking:
			inrange = true
			attack()


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == player:
		inrange = false
