extends CharacterBody2D
class_name enemy
var player: CharacterBody2D
@onready var attack_area: Area2D = $AttackArea
@onready var ani: AnimatedSprite2D = $AnimatedSprite2D
@onready var cdt: Timer = $cdt
var inrange : bool
var attacking : bool
@export var damage : int # attack damage.
@export var maxhp : int # Now that it is an abberatvion I will explain it even though you know it JB. It's max health points.
@export var speed : int # walk speed.
@export var range : int # range for enemy to attack player in pixels.
@export var cd : int # attack cooldown in seconds always less than attack animation time.
@export var regen : int
var hp : int
func _ready() -> void:
	hp = maxhp
	print("Slime Max Hp: ", maxhp)
	print("Slime Hp: ", hp)
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	var target_pos = player.global_position
	if global_position.distance_to(target_pos) < attack_area.get_child(0).shape.radius * 1.5: #to stop when close to player
		velocity = velocity.move_toward(Vector2(0,0), speed * 0.7)
		ani.speed_scale = 1
	elif global_position.distance_to(target_pos) < range: # to walk towards player when player is in range
		ani.speed_scale = 1.75
		target_pos = player.global_position
		velocity = Vector2.from_angle(get_angle_to(target_pos)) * speed
	elif velocity: #stop when player is out of range
		velocity = velocity.move_toward(Vector2(0,0), speed * 0.3)
		ani.speed_scale = 1
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

func hp_update(amt):
#	Use For Healing and Damage
	print("HP", hp)
	hp = clampi(hp + amt, 0, maxhp) 
	if amt < 0:
		if hp > 0:
			var damaged = create_tween()
			damaged.tween_property(ani, "modulate", Color(1, 0, 0), 0.2)
			damaged.tween_property(ani, "modulate", Color(1, 1, 1), 0.05)
		else:
			var damaged = create_tween()
			damaged.tween_property(attack_area, "monitoring", false, 0)
			damaged.tween_property(ani, "modulate", Color(1, 0, 0), 0.2)
			set_physics_process(false)
			await damaged.finished

	if hp == 0:
		ani.animation = "green-dead"
		await get_tree().create_timer(0.4).timeout
		print("Slime Dead")
		queue_free()
