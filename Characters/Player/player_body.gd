extends CharacterBody2D
class_name Player

@onready var state_machine: NodeFiniteStateMachine = $StateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var health: int = 5

const SPEED = 6000.0
const RUN_SPEED = 8000.0
const HURT_SPEED = 10000.0
const JUMP_VELOCITY = -400.0

var double_jump: bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and state_machine.current_node_state_name != "WallJumpState":
		velocity += get_gravity() * delta
	move_and_slide()


func face_direction(direction: float) -> void:
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false
