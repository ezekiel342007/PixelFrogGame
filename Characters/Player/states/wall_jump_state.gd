extends NodeState

@export var player_body_2d: Player
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	animated_sprite_2d.play("wall_jump")
	player_body_2d.velocity = Vector2.ZERO;


func on_physics_process(_delta: float) -> void:
	if GameInput.jump_input():
		transition.emit("DoubleJumpState")

	if GameInput.run_input():
		transition.emit("RunState")


func exit() -> void:
	animated_sprite_2d.stop()
