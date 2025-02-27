extends NodeState

@export var player_body_2d: Player
@export var animated_sprite_2d: AnimatedSprite2D


func enter() -> void:
	animated_sprite_2d.play("idle");


func on_process(_delta: float) -> void:
	if !player_body_2d.is_on_floor():
		transition.emit("FallState")

	if GameInput.jump_input() and player_body_2d.is_on_floor():
		transition.emit("JumpState")

	if GameInput.run_input() and player_body_2d.is_on_floor():
		transition.emit("RunState")


func exit() -> void:
	animated_sprite_2d.stop()
