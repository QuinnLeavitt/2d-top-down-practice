extends CharacterBody2D

@export var max_speed = 250
@export var accel = 1000
@export var friction = 2000

var current_dir = "none"
var input = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	#print(input)
	if input == Vector2.ZERO:
		play_anim(0)
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		if input == Vector2(1,0):
			current_dir = "right"
			play_anim(1)
		elif input == Vector2(-1,0):
			current_dir = "left"
			play_anim(1)
		elif input == Vector2(0,1):
			current_dir = "down"
			play_anim(1)
		elif input == Vector2(0,-1):
			current_dir = "up"
			play_anim(1)
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	#print(current_dir)
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")

	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")

	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")

	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
