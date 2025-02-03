extends Node


@export var max_health :int = 1
@onready var health = max_health : set = set_health


signal no_health
signal second_state

func set_health(value):
	health = value
	
	if health ==5:
		emit_signal('second_state')
	elif health <= 0:
		emit_signal('no_health')
