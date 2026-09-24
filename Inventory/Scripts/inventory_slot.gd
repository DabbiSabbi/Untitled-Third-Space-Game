extends Panel

@onready var slot_high: Sprite2D = $slot_high

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update(item: inventoryitem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true 
		item_visual.texture = item.texture

#func _physics_process(delta):
	#if Input.is_action_just_pressed("slot_1"):
		#slot_high.visible = true

func slot_select():
	slot_high.visible = true
