extends CharacterBody2D
class_name Player
@export var MAX_SPEED:float = 14
@export var acceleration:float = 5
@export var speed:float = 300 
@export var health:float = 0
@export var MAX_HEALTH:float = 100
var weapon
var weapon_equipped:bool= false
var weapon_orbit_radius: float = 1.01 # Distance from the player
@onready var anchor = $Anchor
@onready var anchor_end = $Anchor/AnchorEnd

func _ready():
	health = MAX_HEALTH
	add_to_group("player")

func _physics_process(_delta):
	get_input()
	move_and_slide()
	if weapon_equipped:
		handle_weapon()
#Actions based on input
func get_input():
	#Movement Control
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	#Equipment Managment
	if Input.is_action_just_pressed("equip"):
		print("equipping")
		handleEquip()
	
	#Attacking
	if Input.is_action_just_pressed("attack"):
		attack()
		
func handle_weapon():
	weapon.global_position = global_position
	var mouse_position = get_global_mouse_position()
	var direction_to_mouse = (mouse_position - global_position).normalized()
	weapon.global_position = anchor_end.global_position 
	weapon.look_at(mouse_position)
	anchor.rotate(anchor.get_angle_to(get_global_mouse_position()))


func handleEquip()->void:
	if can_equip_weapon(weapon):
		print("Weapon in range and can be equipped: ", weapon)
		weapon.global_position = global_position
		weapon_equipped = true
	else:
		print("Weapon in range and but can not be equipped: ", weapon)
		

func can_equip_weapon(potential_weapon: Node2D) -> bool:
	if not potential_weapon:
		print("no weapon")
		return false
	print( potential_weapon.call("canBeEquipped"))
	return potential_weapon.call("canBeEquipped") # Call the method on the weapon


func attack()->void:
	if weapon:
		if weapon.has_method('attack'):
			weapon.call('attack')

	
func _on_equip_range_area_entered(area):
	if area.get_parent() is Node2D and area.get_parent().is_in_group("weapons"):
		weapon = area.get_parent()
		
func take_damage(attack)->void:
	health -= attack.damage
