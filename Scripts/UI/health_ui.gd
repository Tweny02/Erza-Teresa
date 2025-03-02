extends Control


# ===========================VAR==========================
var hearts = 4 : set = set_hearts 
var max_hearts = 1 : set = set_max_hearts

@onready var heartUIEmpty = $HeartUIEmpty
@onready var heartUIFull = $HeartUIFull
# ==========================FUNC=======================
func set_hearts(value):
	hearts = clamp(value, 0, 10)
	if heartUIFull != null:
		heartUIFull.size.x = hearts * 15
	
func set_max_hearts(value):
	max_hearts = clamp(value, 1, 10)
	if heartUIEmpty != null:
		heartUIEmpty.size.x = hearts * 15
	
func _ready():
	self.max_hearts = PlayerStates.max_health
	self.hearts = PlayerStates.health
	
	PlayerStates.connect('max_health_changed',Callable(set_max_hearts))
	PlayerStates.connect('health_changed',Callable(set_hearts))
	
	
