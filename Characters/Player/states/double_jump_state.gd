extends NodeState

@export var player_body_2d: Player
@export var animated_sprite_2d: AnimatedSprite2D

@export_category("Double Jump")
@export var jump_height: float = -250
@export var jump_velocity: float = -250
@export var horizontal_distance: float = 800
@export var horizontal_speed: float = 700


func enter() -> void:
	animated_sprite_2d.play("double_jump")


func on_physics_process(_delta: float) -> void:
	player_body_2d.velocity += player_body_2d.get_gravity() * _delta

	if !player_body_2d.double_jump:
		player_body_2d.velocity.y = jump_velocity
		player_body_2d.double_jump = true

	var direction: float = GameInput.run_input()

	if direction:
		player_body_2d.velocity.x += horizontal_distance * direction * _delta
		player_body_2d.velocity.x = clamp(player_body_2d.velocity.x, -horizontal_distance, horizontal_distance)
	
	player_body_2d.face_direction(direction)

	player_body_2d.move_and_slide()

	# Transistion to Fall State
	if player_body_2d.velocity.y > 0:
		transition.emit("FallState")


func exit() -> void:
	animated_sprite_2d.stop()
