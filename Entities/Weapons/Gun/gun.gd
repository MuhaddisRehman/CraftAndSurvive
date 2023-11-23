extends Node2D
var can_be_equipped:bool = false
@export var ammo:int = 5
@export var shoot_speed:float = 1
@export var attack_damge:float = 5
@export var bullet_scene:PackedScene
@onready var muzzle = $Muzzle
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	add_to_group("weapons")

func _on_equip_range_body_entered(body):
	if body.is_in_group("player"):
		can_be_equipped = true
		print("weapon range:",can_be_equipped)
func canBeEquipped() -> bool:
	print("weapon function:",can_be_equipped)
	return can_be_equipped


func _on_equip_range_area_entered(area):
	if area.get_parent().is_in_group("player"):
		can_be_equipped = true
		print("weapon range:",can_be_equipped)

func attack()->void:
	var bullet = bullet_scene.instantiate()
	bullet.position = muzzle.get_global_position()
	audio_stream_player_2d.play()
	add_child(bullet)
	print('pew pew')
