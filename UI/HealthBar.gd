extends ProgressBar
@export var player:Player

func _update():
		value = player.health*100/player.MAX
