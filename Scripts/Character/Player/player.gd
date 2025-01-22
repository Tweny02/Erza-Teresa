'''
v0.0.4.20250122

	# State Machine
		- attack anime
	# CONST.
		- enumrater
	# EEffrct
		- grass effect
		
'''

extends CharacterBody2D

# ---------------CONST.----------------
const MAX_SPEED = 100.0
const ACCELERATION = 90
const FRICTION = 500

enum {MOVE,ROLL,ATTACK}

# ====================VAR======================
var state = MOVE
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")



# ---------------FUNC------------------
func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()
		ROLL:
			roll_state()
	
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		
		animationState.travel('Run')
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED , ACCELERATION * delta)
		
				 
		 
	else:
		animationState.travel('Idle')
		
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	if Input.is_action_just_pressed('attack'):
		state = ATTACK 
	
	
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel('Attack')
func attack_animation_finished():
	state = MOVE
	
func roll_state():
	pass
