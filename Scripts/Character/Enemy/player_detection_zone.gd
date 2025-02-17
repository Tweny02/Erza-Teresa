extends Area2D


var player = null

# ========================FUNC========================V
func can_see_player():
	return player != null

func _on_body_entered(body):
	player = body


func _on_body_exited(_body):
	player = null
