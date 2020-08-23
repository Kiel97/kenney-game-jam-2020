extends KinematicBody2D

const GRAVITY = 2000.0
const BASE_MOVE_SPEED = 500
const BASE_JUMP_SPEED = -500

var move_boost = 0.0 setget set_move_boost
var jump_boost = 0.0 setget set_jump_boost

var velocity : Vector2 = Vector2()

func _process(_delta: float) -> void:
	update_animation()

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
		flip_character(false)
	elif left:
		velocity.x -= get_current_move_speed()
		flip_character(true)
	
	if jump and is_on_floor():
		velocity.y = get_current_jump_force()

func update_animation() -> void:
	if velocity.y < 0:
		$anim.play("jump")
	elif velocity.y > 0:
		$anim.play("fall")
	elif abs(velocity.x) > 0:
		$anim.play("walk")
	else:
		$anim.play("idle")

func get_current_move_speed() -> float:
	return BASE_MOVE_SPEED + BASE_MOVE_SPEED * move_boost

func get_current_jump_force() -> float:
	return BASE_JUMP_SPEED + BASE_JUMP_SPEED * jump_boost

func flip_character(is_left: bool) -> void:
	$Sprite.flip_h = is_left

func increase_move_boost(value: float) -> void:
	self.move_boost += value
	clamp(move_boost, 0, 1)
	
func increase_jump_force(value: float) -> void:
	self.jump_boost += value
	clamp(jump_boost, 0, 1)

func set_move_boost(value) -> void:
	move_boost = value
	print(move_boost)

func set_jump_boost(value) -> void:
	jump_boost = value
	print(jump_boost)
