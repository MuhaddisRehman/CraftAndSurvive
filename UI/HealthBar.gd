extends ProgressBar
@export var player:Player

func _physics_process(delta):
	_update()
func _update():
	if player:
		value = player.health*100/player.MAX_HEALTH
