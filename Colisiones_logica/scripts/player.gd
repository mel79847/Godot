extends CharacterBody2D

# PROPERTIES
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_key = false
var has_gem = false
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var timer: Timer = $Timer

enum {
	WALK,
	DUCK,
	JUMP,
	IDLE
}

var state = IDLE
var hp = 3

signal auch

func _physics_process(delta: float) -> void:
	# add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		state_machine.travel("Jump")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		state_machine.travel("Jump")
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		state_machine.travel("Walk")
		if direction < 0:
			$Sprite2D.scale.x = abs($Sprite2D.scale.x) * -1
		elif direction > 0:
			$Sprite2D.scale.x = abs($Sprite2D.scale.x)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		state_machine.travel("Idle")
		
	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if (!has_gem):
		print("Ouch!!!")
		hp-=1
		auch.emit()
	elif (area.name == "Fireball"):
		print("iwi")
		
func get_gem():
	print("Conseguiste la gema! matalos a todos!")
	has_gem = true;
	$Hitbox/CollisionShape2D.disabled=false
	$Sprite2D.modulate = Color(0.5, 0.8, 1.0)
	timer.one_shot = true
	timer.wait_time = 5
	timer.start()
	
func _on_timer_timeout() -> void:
	has_gem = false
	$Hitbox/CollisionShape2D.disabled=true
	$Sprite2D.modulate = Color(1, 1, 1)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if has_gem:
		area.get_parent().queue_free()
