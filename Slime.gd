extends KinematicBody2D

const GRAVITY = 2000.0
const MOVE_SPEED = 200

enum DIRECTIONS {LEFT, RIGHT}

var current_direction = DIRECTIONS.LEFT
var velocity : Vector2 = Vector2()

func _ready() -> void:
	$AnimationPlayer.play("walk")

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	velocity.x = MOVE_SPEED * (-1 if current_direction == DIRECTIONS.LEFT else 1)

	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "PlayerCorr":
			collision.collider.die()
	
	if is_on_wall():
		change_direction()

func change_direction():
	match current_direction:
		DIRECTIONS.LEFT:
			current_direction = DIRECTIONS.RIGHT
			$Sprite.flip_h = true
		DIRECTIONS.RIGHT:
			current_direction = DIRECTIONS.LEFT
			$Sprite.flip_h = false
		_:
			current_direction = DIRECTIONS.LEFT
			$Sprite.flip_h = false
	print(current_direction)
