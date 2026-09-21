extends GridContainer
var current_slot = 0


func slot_selection(a,b):
	
	if Input.is_action_just_pressed(a):
		get_child(current_slot).slot_high.visible = false
		get_child(b).slot_select()
		current_slot = b

func _process(delta):
	slot_selection("slot_1", 0)
	slot_selection("slot_2", 1)
	slot_selection("slot_3", 2)
	slot_selection("slot_4", 3)
	slot_selection("slot_5", 4)
