extends NodeState

@export var player_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	animated_sprite_2d.play("run")
	player_body_2d.double_jump = false


func on_physics_process(_delta: float) -> void:
	var direction: float = GameInput.run_input()
	if direction:
		player_body_2d.velocity.x += direction * player_body_2d.SPEED
		player_body_2d.velocity.x = clamp(player_body_2d.velocity.x, -player_body_2d.MAX_SPEED * _delta, player_body_2d.MAX_SPEED * _delta)
	else:
		player_body_2d.velocity.x = move_toward(player_body_2d.velocity.x, 0, player_body_2d.SPEED * _delta)

	player_body_2d.face_direction(direction)

	player_body_2d.move_and_slide()

	# Transition to Idle State
	if player_body_2d.velocity.x == 0:
		transition.emit("IdleState")

	# Transition to Jump State
	if GameInput.jump_input():
		transition.emit("JumpState")

	# Transition to fall State
	if !player_body_2d.is_on_floor():
		transition.emit("FallState")


func exit() -> void:
	animated_sprite_2d.stop()
