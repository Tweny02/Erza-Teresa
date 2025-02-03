extends Node2D



func create_grass_effect():
	
	var grassEffect = load("res://Prefab/Effect/GrassEfect.tscn")
	var _grass_effect = grassEffect.instantiate()
	var LEVEL_01 = get_tree().current_scene
	
	LEVEL_01.add_child(_grass_effect)
	_grass_effect.global_position = global_position
	


func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
