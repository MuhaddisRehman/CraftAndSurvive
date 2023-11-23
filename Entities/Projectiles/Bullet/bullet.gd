extends Area2D
@export var speed = 5000
var damage:float = 5
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_life_time_timeout():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy") && body.has_method("take_damage"):
		print( body, " was hit.")
		body.take_damage(damage)
		queue_free()
		
