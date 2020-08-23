extends KinematicBody2D

const GRAVITY = 2000.0
const BASE_MOVE_SPEED = 500
const BASE_JUMP_SPEED = -500

var move_boost = 0.0
var jump_boost = 0.0

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
		velocity.x += get_current_move_speed()
	elif left:
		velocity.x -= get_current_move_speed()
	
	if jump and is_on_floor():
		velocity.y = get_current_jump_force()

func get_current_move_speed() -> float:
	return BASE_MOVE_SPEED + BASE_MOVE_SPEED * move_boost

func get_current_jump_force() -> float:
	return BASE_JUMP_SPEED + BASE_JUMP_SPEED * jump_boost
