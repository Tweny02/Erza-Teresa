extends CharacterBody2D


# ========================CONST=============================
const  EnemyDeathEffect = preload("res://Prefab/Effect/EnemyDeathEffect.tscn")
enum {IDLE,WANDER,CHASE}
@export var MAX_SPEED = 50
@export var ACCELERATION = 300
@export  var FRICTION = 200
# ========================VAR==============================
@onready var states = $States
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var sprite = $AnimatedSprite
@onready var hurtbox = $Hurtbox
@onready var softCollision = $SoftCollision
var state = CHASE
# =========================FUNC========================

	
	
func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				sprite.flip_h = velocity.x < 0	
				
	# 击退速度
	velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
	
	if softCollision.is_colliding():
		velocity =softCollision.get_push_vector() * delta * 400
	move_and_slide()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_hurtbox_area_entered(area):
	states.health -= area.damage
	print('蝙蝠生命：')
	print(states.health)
	velocity = area.velocity_vector * 120
	hurtbox.create_hit_effect()
func _on_states_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
