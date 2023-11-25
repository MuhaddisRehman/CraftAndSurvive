extends CharacterBody2D


@export var SPEED = 200.0
@export var attack_damage:float
@export var health:float = 0
@export var MAX_HEALTH:float = 100
@export var player_scn:Player
@onready var health_bar = $HealthBar

func _ready():
	add_to_group("enemy")
	health = MAX_HEALTH
	health_bar.value = health
func _physics_process(delta):
	pursue(delta)


func take_damage(damage)->void:
	
	health -= damage 
	health_bar.value = health
	if health <= 0:
		die()

func pursue(delta:float)->void:
	if player_scn:
		var direction = (player_scn.global_position - global_position).normalized()
		velocity = direction * SPEED 
		move_and_slide()

func die()->void:
	queue_free()
