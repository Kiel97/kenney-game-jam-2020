extends KinematicBody2D

const GRAVITY = 2000.0
const MOVE_SPEED = 500
const JUMP_SPEED = -960

onready var anim_player = $AnimationPlayer
onready var attack_anim = $Body/ForeArm/AttackAnim

var velocity : Vector2 = Vector2()
var arm_look_at_mouse: bool = true

func _process(_delta: float) -> void:
	var global_mouse_pos = get_global_mouse_position()
	flip_sprites(global_mouse_pos > self.position)
	$Body/Head.look_at(global_mouse_pos)
	
	if arm_look_at_mouse:
		$Body/ForeArm.look_at(global_mouse_pos)

func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("attack") and not attack_anim.is_playing():
			arm_look_at_mouse = false
			attack_anim.play("attack")

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
		anim_player.play("walk")
	elif left:
		velocity.x -= MOVE_SPEED
		anim_player.play("walk")
	else:
		anim_player.play("idle")
	
	if jump and is_on_floor():
		velocity.y = JUMP_SPEED

func flip_sprites(is_right: bool) -> void:
	$Body.scale = Vector2(1,1) if is_right else Vector2(-1,1)

func _on_AttackAnim_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		arm_look_at_mouse = true
