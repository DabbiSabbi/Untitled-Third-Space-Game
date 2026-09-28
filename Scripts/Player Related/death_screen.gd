extends Control
var player: CharacterBody2D 
var bg: Tween
var text: Tween
var fading:= false
@onready var label: Label = $ColorRect/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	if player.hp == 0 and fading == false:
		fading = true
		$ColorRect.visible = true
		bg = create_tween()
		bg.tween_property($ColorRect, "color", Color(0.0, 0.0, 0.0, 0.0), 0)
		bg.tween_property($ColorRect, "color", Color(0.0, 0.0, 0.0, 1.0), 2)
		 
		text = create_tween()
		text.tween_property(label, "theme_override_colors/font_color", Color(0.0, 0.0, 0.0, 0.0), 0)
		text.tween_property(label, "theme_override_colors/font_color", Color(1.0, 0.0, 0.0, 1.0), 2)
