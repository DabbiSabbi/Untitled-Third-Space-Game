extends GridContainer
var current_slot : int = 6
var player : CharacterBody2D

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")

func slot_selection(a,b):
	if Input.is_action_just_pressed(a):
		if current_slot == 6:
			get_child(b).slot_select()
			current_slot = b
		elif current_slot == b:
			get_child(current_slot).slot_high.visible = false
			player.held_item(null, b)
			current_slot = 6
		else:
			get_child(current_slot).slot_high.visible = false
			get_child(b).slot_select()
			current_slot = b


func _process(delta):
	slot_selection("slot_1", 0)
	slot_selection("slot_2", 1)
	slot_selection("slot_3", 2)
	slot_selection("slot_4", 3)
	slot_selection("slot_5", 4)
