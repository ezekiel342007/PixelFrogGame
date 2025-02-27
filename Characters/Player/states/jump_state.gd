extends NodeState

@export var player_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

func enter() -> void:
	animated_sprite_2d.play("Jump")


func on_physics_process(_delta: float) -> void:
	var direction = GameInput.run_input()

	if direction:
		player_body_2d.velocity.x = player_body_2d.SPEED * direction * _delta
	else:
		player_body_2d.velocity.x = move_toward(player_body_2d.velocity.x, 0, player_body_2d.SPEED * _delta)

	player_body_2d.face_direction(direction)

	player_body_2d.move_and_slide()


func exit() -> void:
	animated_sprite_2d.stop()
