extends Node

@export var state_machine: NodeFiniteStateMachine


func _on_hurt_box_body_entered(body: Node2D) -> void:
	state_machine.transitiion_to("HurtState")
