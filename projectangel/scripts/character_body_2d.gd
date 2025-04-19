extends CharacterBody2D

@onready var damage_numbers_origin = $Marker2D
@export var speed = 50
@export var dash_speed = 500
var can_take_damage = true
var is_dashing = false
var dash_is_on_cd = false
var special_1_is_on_cd = false
@export var dash_duration = 1.0
@export var Special1CD = 20.0
var cash = 0
var regenRate = 10
var MAXHP = 10
var health = 10
var lvl_max_HP = 0
var lvl_max_speed = 0
var lvl_regen = 0
var lvl_damage = 0
var lvl_abilityCD = 0
var lvl_abilitySize = 0
var abilityCDMOD = 1
var Ability_size_mod = 1


func _ready() -> void:
	add_to_group("player")
	$Special_1_CD.wait_time = Special1CD
	nat_heal()


func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if !is_dashing:
		velocity = input_dir * speed
	if Input.is_action_just_pressed("debug_take_damage"):
		take_damage()
	if input_dir.length() != 0:
		$AnimatedSprite2D.play("run");
	else:
		$AnimatedSprite2D.play("idle");
	if (get_global_mouse_position() - get_global_transform().get_origin()).dot(Vector2(-1, 0)) > 0:
		$AnimatedSprite2D.flip_h = true;
	else:
		$AnimatedSprite2D.flip_h = false;
	if Input.is_action_just_pressed("movement"):
		if !dash_is_on_cd:
			dash(input_dir)
	if Input.is_action_just_pressed("strong ability"):
		if !special_1_is_on_cd:
			spec_aby_1()
		
func _physics_process(delta):
	get_input()
	move_and_slide()
	
func take_damage():
	DamageNumbers.display_numbers(-1, damage_numbers_origin.global_position, Color(1, 1, 1, 1), 21)
	health -= 1
	if health == 0: 
		game_over()

func heal():
	if health != MAXHP:
		health += 1
		DamageNumbers.display_numbers(1, damage_numbers_origin.global_position, Color(0, 1, 0, 1), 21)
	
func dash(input_dir):   
	dash_is_on_cd = true
	is_dashing = true
	can_take_damage = false
	velocity = input_dir * dash_speed
	$DashTimer.wait_time = dash_duration
	$DashTimer.start(0.0)
	await $DashTimer.timeout
	velocity = Vector2.ZERO
	is_dashing = false
	can_take_damage = true
	$DashCD.start(0.0)

func spec_aby_1():
	const ABILITY = preload("res://scenes/special_1.tscn")
	var new_ability = ABILITY.instantiate()
	new_ability.damage = 1 + lvl_damage 
	new_ability.global_position = global_position
	new_ability.scale = Vector2(Ability_size_mod, Ability_size_mod)
	get_parent().add_child(new_ability)
	special_1_is_on_cd = true
	$Special_1_CD.wait_time = Special1CD * abilityCDMOD
	$Special_1_CD.start(0.0)


func game_over():
	$"../GameOverScreen".visible = true
	queue_free()

func nat_heal():
	while 1:
		$NatHealCD.wait_time = regenRate
		$NatHealCD.start(0.0)
		await $NatHealCD.timeout
		if health < MAXHP:
			heal()

func lvl_up_max_health():
	lvl_max_HP += 1
	MAXHP += 2

func lvl_up_max_speed():
	lvl_max_speed
	speed += 50

func lvl_up_regen():
	lvl_regen += 1
	regenRate /= 1.05

func lvl_up_abilityCD():
	lvl_abilityCD += 1
	abilityCDMOD /= 1.05
	

func lvl_up_ability_size():
	lvl_abilitySize += 1
	Ability_size_mod /= 1.05

func lvl_up_damage():
	lvl_damage += 1
	$CastArea.lvl_up_damage()
	$MeeleAttackRotation.damage += 1

func lvl_up_projectile_count():
	$CastArea.lvl_up_spread()
	
func lvl_up_projectile_burst():
	$CastArea.lvl_up_repeat()
	
func lvl_up_projectile_cooldown():
	$CastArea.lvl_up_cooldown()

	
	

func _on_dash_cd_timeout() -> void:
	dash_is_on_cd = false
	

func _on_special_1_cd_timeout() -> void:
	special_1_is_on_cd = false
	
