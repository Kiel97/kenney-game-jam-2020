

extends KinematicBody2D

const GRAVITY = 2000.0
const MOVE_SPEED = 500
const JUMP_SPEED = -960

var velocity : Vector2 = Vector2()

func _physics_process(delta) -> void:
	velocity.y += GRAVITY * delta
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func get_input() -> void:
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var jump = Input.is_action_just_pressed("jump")
	
	velocity.x = 0
	if right:
		velocity.x += MOVE_SPEED
		flip_sprites(true)
		$AnimationPlayer.play("walk")
	elif left:
		velocity.x -= MOVE_SPEED
		flip_sprites(false)
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
	
	if jump:
		velocity.y = JUMP_SPEED

func flip_sprites(is_right: bool) -> void:
	$Body.scale = Vector2(1,1) if is_right else Vector2(-1,1)
