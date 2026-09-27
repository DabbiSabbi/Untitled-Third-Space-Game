extends Panel

@onready var slot_high: Sprite2D = $slot_high

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

var item_scene : PackedScene
var playerv : CharacterBody2D
func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		playerv = get_tree().get_first_node_in_group("Player")

func update(item: inventoryitem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true 
		item_visual.texture = item.texture
		item_scene = item.scene

#func _physics_process(delta):
	#if Input.is_action_just_pressed("slot_1"):
		#slot_high.visible = true

func slot_select():
	slot_high.visible = true
	if playerv:
		print(item_scene)
		playerv.held_item(item_scene)
