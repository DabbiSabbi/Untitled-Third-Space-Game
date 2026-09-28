extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _on_xray_body_entered(body: Node2D) -> void:
	if body is player:
		sprite_2d.self_modulate.a = 0.5

func _on_xray_body_exited(body: Node2D) -> void:
	if body is player:
		sprite_2d.self_modulate.a = 1
