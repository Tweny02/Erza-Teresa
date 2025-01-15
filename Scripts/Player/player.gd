'''
【v1.0.0.20250101】



v0.0.1.20250101

	# Prefab
		- save branch as scene
		- git uplode github
	# Animation
		- animation tree	
'''

extends CharacterBody2D

# ---------------CONST.----------------
const MAX_SPEED = 100.0
const ACCELERATION = 80
const FRICTION = 500

# -------------VAR-----------------
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
# ---------------FUNC------------------



func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animationTree.set("parameters/Idle/blend_position", input_vector)
		#animationPlayer.set("parameters/Run/blend_position", input_vector)
				 
		 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		

	
	move_and_slide()
