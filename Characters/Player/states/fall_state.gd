extends NodeState

@export var player_body_2d: Player
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	animated_sprite_2d.play("fall")


func on_physics_process(_delta: float) -> void:
	if player_body_2d.is_on_floor():
		transition.emit("IdleState")

	var direction: float = GameInput.run_input()
	if direction:
		player_body_2d.velocity.x = direction * player_body_2d.SPEED * _delta
	else:
		player_body_2d.velocity.x = move_toward(player_body_2d.velocity.x, 0, player_body_2d.SPEED * _delta)

	player_body_2d.face_direction(direction)
	player_body_2d.move_and_slide()

	if !player_body_2d.is_on_floor() and GameInput.jump_input():
		transition.emit("DoubleJumpState")


func exit() -> void:
	animated_sprite_2d.stop()
