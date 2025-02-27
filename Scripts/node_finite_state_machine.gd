extends Node
class_name NodeFiniteStateMachine

@export var initial_node_state: NodeState = get_child(0)

var node_states: Dictionary = {}
var current_node_state: NodeState
var current_node_state_name: String


func _ready() -> void:
	for node in get_children():
		if node is NodeState:
			node_states[node.name.to_lower()] = node
			node.transition.connect(transition_to)

	if initial_node_state:
		current_node_state = initial_node_state;
		current_node_state_name = current_node_state.name
		initial_node_state.enter()


func _input(event: InputEvent) -> void:
	if current_node_state: current_node_state.on_input(event)


func _process(delta: float) -> void:
	if current_node_state: current_node_state.on_process(delta)


func _physics_process(delta: float) -> void:
	if current_node_state: current_node_state.on_physics_process(delta)


func transition_to(new_node_name: String) -> void:
	if current_node_state_name == new_node_name.to_lower():
		return

	var new_node: NodeState = node_states[new_node_name.to_lower()]

	if !new_node:
		return

	if current_node_state:
		current_node_state.exit()

	current_node_state = new_node
	current_node_state_name = current_node_state.name
	current_node_state.enter()
