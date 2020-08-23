extends KinematicBody2D

const FLY_SPEED = 400

var velocity : Vector2 = Vector2()

var on_screen

func _ready() -> void:
	$AnimationPlayer.play("fly")
	on_screen = false

func _physics_process(delta: float) -> void:
	if on_screen:
		velocity.x = -FLY_SPEED
	
		velocity = move_and_slide(velocity, Vector2(0, 0))
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.name == "PlayerCorr":
				collision.collider.die()

func _on_VisibilityEnabler2D_screen_entered() -> void:
	on_screen = true

func _on_VisibilityEnabler2D_screen_exited() -> void:
	on_screen = false
