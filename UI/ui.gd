extends CanvasLayer
class_name UI
@onready var score_label = %Score
var score = 0


func _ready()->void:
	_update_score_label()

func _update_score_label()->void:
	score_label.text = str(score)
