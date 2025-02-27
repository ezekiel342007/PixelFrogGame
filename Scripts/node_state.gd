extends Node
class_name NodeState

signal transition(new_node_state_name: String)


func enter() -> void:
	pass


func on_process(_delta: float) -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	pass


func exit() -> void:
	pass
