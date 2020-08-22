extends KinematicBody2D

const GRAVITY = 2000.0
const MOVE_SPEED = 500
const JUMP_SPEED = -960

var velocity : Vector2 = Vector2()

onready var anim_player = $AnimationPlayer

func _physics_process(delta) -> void:
	velocity.y += GRAVITY * delta
	get_input()
	
	var global_mouse_pos = get_global_mouse_position()
	flip_sprites(global_mouse_pos > self.position)
	$Body/Head.look_at(global_mouse_pos)
	$Body/ForeArm.look_at(global_mouse_pos)
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func get_input() -> void:
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var jump = Input.is_action_just_pressed("jump")
	
	velocity.x = 0
	if right:
		velocity.x += MOVE_SPEED
		anim_player.play("walk")
	elif left:
		velocity.x -= MOVE_SPEED
		anim_player.play("walk")
	else:
		anim_player.play("idle")
	
	if jump:
		velocity.y = JUMP_SPEED

func flip_sprites(is_right: bool) -> void:
	$Body.scale = Vector2(1,1) if is_right else Vector2(-1,1)
