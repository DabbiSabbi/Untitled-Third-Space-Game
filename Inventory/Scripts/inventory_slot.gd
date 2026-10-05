extends Panel

@onready var slot_high: Sprite2D = $slot_high
@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var quantity_label: Label = $CenterContainer/Panel/quantity

var item_resource
var quantity : int = 1
var item_scene : PackedScene
var playerv : CharacterBody2D
func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		playerv = get_tree().get_first_node_in_group("Player")
	if get_tree().get_first_node_in_group("Inventory"):
		playerv = get_tree().get_first_node_in_group("Inventory")



func update(item: inventoryitem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true 
		item_visual.texture = item.texture
		item_scene = item.scene
		if item.stackable == true:
			quantity_label.visible = true
			quantity_label.text = str(quantity)
	item_resource = item


#func _physics_process(delta):
	#if Input.is_action_just_pressed("slot_1"):
		#slot_high.visible = true

func slot_select():
	slot_high.visible = true
	if playerv:
		playerv.held_item(item_scene, get_index())
		
func consume(amt):
	quantity -= amt
	quantity_label.text = str(quantity)
	if quantity <= 0:
		pass

func stacking():
	if item_resource:
		if item_resource.stackable:
			quantity += 1
			quantity_label.text = str(quantity)
			
	
	
	
