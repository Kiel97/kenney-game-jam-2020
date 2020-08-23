extends KinematicBody2D

const FLY_SPEED = 400

var velocity : Vector2 = Vector2()

func _ready() -> void:
	$AnimationPlayer.play("fly")

func _physics_process(delta: float) -> void:

	velocity.x = -FLY_SPEED

	velocity = move_and_slide(velocity, Vector2(0, 0))
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "PlayerCorr":
			collision.collider.die()
