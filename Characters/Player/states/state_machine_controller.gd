extends Node

@export var state_machine: NodeFiniteStateMachine

@onready var player: Player = $"../"


func _on_hurt_box_body_entered(body: Node2D) -> void:
	state_machine.transitiion_to("HurtState")


func _physics_process(_delta: float) -> void:
	if player.is_on_wall() and !player.is_on_floor() and state_machine.current_node_state_name != "DoubleJumpState":
		state_machine.transition_to("WallJumpState")
