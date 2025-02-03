extends CharacterBody2D


# ========================CONST=============================
const  FRICTION = 200
# ========================VAR==============================
@onready var states = $States

# =========================FUNC========================

	
	
func _physics_process(delta):
	# 击退速度
	velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
	
	move_and_slide()


func _on_hurtbox_area_entered(area):
	states.health -= area.damage
	print(states.health)
	velocity = area.velocity_vector * 120
	


func _on_states_no_health():
	queue_free()


func _on_states_second_state():
	print("第二阶段")
