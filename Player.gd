extends KinematicBody2D

signal changed_jump_boost(value)
signal changed_move_boost(value)
signal died()

const GRAVITY = 2000.0
const BASE_MOVE_SPEED = 500
const BASE_JUMP_SPEED = -570

const MOVE_BOOST_DET_VALUE = 0.01
const JUMP_BOOST_DET_VALUE = 0.05

var move_boost = 0.0 setget set_move_boost
var jump_boost = 0.0 setget set_jump_boost

var velocity : Vector2 = Vector2()

func _process(_delta: float) -> void:
	update_animation()

func _physics_process(delta) -> void:
	velocity.y += GRAVITY * delta
	get_input()

	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Hazards" or collision.collider.is_in_group("enemy"):
			die()

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
		self.jump_boost -= JUMP_BOOST_DET_VALUE
		$Jump_SFX.play()

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
	
func increase_jump_force(value: float) -> void:
	self.jump_boost += value

func set_move_boost(value) -> void:
	value = clamp(value, 0, 1)
	move_boost = value
	emit_signal("changed_move_boost", move_boost)

func set_jump_boost(value) -> void:
	value = clamp(value, 0, 1)
	jump_boost = value
	emit_signal("changed_jump_boost", jump_boost)

func _on_MoveBoostDetTimer_timeout() -> void:
	self.move_boost -= MOVE_BOOST_DET_VALUE

func stop_animation() -> void:
	$anim.stop()

func stop_player() -> void:
	$MoveBoostDetTimer.stop()
	$CollisionShape2D.call_deferred("set_disabled", true)
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func die() -> void:
	$anim.play("hurt")
	stop_player()
	emit_signal("died")
