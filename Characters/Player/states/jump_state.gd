extends NodeState

@export var player_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@export_category("Jump State")
@export var horizontal_jump_distance: float = 550
@export var max_horizontal_distancne: float = 450


func enter() -> void:
	animated_sprite_2d.play("jump")


func on_physics_process(_delta: float) -> void:
	player_body_2d.velocity += player_body_2d.get_gravity() * _delta

	if player_body_2d.is_on_floor():
		player_body_2d.velocity.y = player_body_2d.JUMP_VELOCITY

	var direction = GameInput.run_input()

	if direction:
		player_body_2d.velocity.x += horizontal_jump_distance * direction * _delta
		player_body_2d.velocity.x = clamp(player_body_2d.velocity.x, -max_horizontal_distancne, max_horizontal_distancne)
	else:
		player_body_2d.velocity.x = move_toward(player_body_2d.velocity.x, 0, horizontal_jump_distance * _delta)

	player_body_2d.face_direction(direction)
	player_body_2d.move_and_slide()

	if !player_body_2d.is_on_floor() and GameInput.jump_input():
		transition.emit("DoubleJumpState")

	# Transition to Idle State
	if player_body_2d.is_on_floor() and !GameInput.run_input():
		transition.emit("IdleState")

	# Transition to Run State
	if player_body_2d.is_on_floor() and GameInput.run_input():
		transition.emit("RunState")

	# Transistion to Fall State
	if player_body_2d.velocity.y > 0 and !GameInput.jump_input():
		transition.emit("FallState")


func exit() -> void:
	animated_sprite_2d.stop()
