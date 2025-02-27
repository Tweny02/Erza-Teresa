'''
# Godot v4.3
v0.2.1.20250227
	# 问题修复
		- 成功解决图层排序问题，我们b站的大神太多了
		- z index也可排序图层
	# SoundFX
		- 添加音效	
	# 打包为.exe文件
'''

extends CharacterBody2D

# =====================CONST========================
const PlayerHurtSound = preload("res://Prefab/Character/Player/PlayerHurtSound.tscn")

@export var MAX_SPEED = 100.0
@export var ACCELERATION = 500
@export var FRICTION = 500
@export var ROLL_SPEED = 120

enum {MOVE,ROLL,ATTACK}

# ====================VAR======================
var state = MOVE
var roll_vector = Vector2.DOWN
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var swordHitbox = $Marker2D/SwordHitbox
@onready var hurtbox = $Hurtbox


# =======================FUNC========================
func _ready():
	animationTree.active = true
	swordHitbox.velocity_vector = roll_vector
	PlayerStates.no_health.connect(queue_free)
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()
		ROLL:
			roll_state(delta)
	move_and_slide()
	
# state machine	
func move_state(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.velocity_vector = input_vector
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		
		animationState.travel('Run')
		
		
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED , ACCELERATION * delta)
		
				 
		 
	else:
		animationState.travel('Idle')
		
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	
	
	if Input.is_action_just_pressed('attack'):
		state = ATTACK 
	elif Input.is_action_just_pressed('roll'):
		
		state = ROLL 
		
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel('Attack')
func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel('Roll')
# 动作完成
func attack_animation_finished():
	state = MOVE
func roll_animation_finished():
	
	state = MOVE
	
func _on_hurtbox_area_entered(_area):
	PlayerStates.health -= 1
	print("玩家生命：")
	print(PlayerStates.health)
	hurtbox.start_invincible(1)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instantiate()
	get_tree().current_scene.add_child(playerHurtSound)
