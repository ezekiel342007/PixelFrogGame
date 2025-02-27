extends Node

func run_input() -> float:
	return Input.get_axis("move_backward", "move_forward")


func jump_input() -> bool:
	return Input.is_action_just_pressed("jump")


func super_input() -> bool:
	return Input.is_action_just_pressed("super")
