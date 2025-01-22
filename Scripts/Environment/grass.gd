extends Node2D



func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		var grassEffect = load("res://Prefab/Effect/GrassEfect.tscn")
		var _grass_effect = grassEffect.instantiate()
		var LEVEL_01 = get_tree().current_scene
		
		LEVEL_01.add_child(_grass_effect)
		_grass_effect.global_position = global_position
		queue_free()
