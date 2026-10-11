extends Control
@onready var inventory: inventory = preload("uid://v87okaswmvj8")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var grid_container: GridContainer = $NinePatchRect/GridContainer
var Player:player
@onready var items := inventory.items
var itemsq := {}
func _ready():
	update_slots()
	print("Items: ", items)
	for i in items:
		pass
	if get_tree().get_first_node_in_group("Player"):
		Player = get_tree().get_first_node_in_group("Player")

func update_slots():
	for i in range(min(items.size(), slots.size())):
		slots[i].update(items[i])
		

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("drop"):
		if grid_container.current_slot !=6:
			var item = slots[grid_container.current_slot].item_resource
			if item != null:
				slots[grid_container.current_slot].consume(1)
				var drop = preload("uid://hdt3kbyctwe4").instantiate()
				drop.item = item
				drop.docurve = true
				drop.angle = Vector2(0,1)
				drop.parent_pos = Player.global_position
				drop.distance = 9
				Player.get_tree().root.add_child(drop)

func pickup(item):
	for i in items.size():
		print("Item: ", item)
		print("slot: ", items[i])
		if items[i] == item and slots[i].quantity + 1 <= slots[i].item_resource.maxquantity:
			slots[i].stacking()
			break
		elif items[i] == null:
			print("picked up ", item)
			items[i] = item
			update_slots()
			break

func deplete(slot):
	items[slot] = null
	update_slots()
