extends Node

@export var state_machine: NodeFiniteStateMachine

@onready var player: Player = $"../"
@onready var hurt_state: Node = $"../StateMachine/HurtState"


func _on_hurt_box_body_entered(body: Node2D) -> void:
	player.health -= hurt_state.hurt_degrees[body.name.to_lower()]["damage"]
	hurt_state.hurt_time = hurt_state.hurt_degrees[body.name.to_lower()]["hurt_time"]
	print(player.health)
	state_machine.transition_to("HurtState")


func _physics_process(_delta: float) -> void:
	# if player.is_on_wall() and !player.is_on_floor() and state_machine.current_node_state_name != "DoubleJumpState":
		# state_machine.transition_to("WallJumpState")
	pass
