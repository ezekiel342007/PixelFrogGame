using Godot;

public partial class NodeFiniteStateMachineCS: Node
{
	private static NodeState currentNodeState;
	private static string currentNodeStateName;
	private NodeState initialNodeState;
	private static Godot.Collections.Dictionary<string, NodeState> nodeStates = new Godot.Collections.Dictionary<string, NodeState>();

	public override void _Ready()
	{
		for (int i = 0; i < GetChildren().Count; i++)
		{
			var node = GetChild<NodeState>(i);
			nodeStates.Add(node.Name, node);
			node.Transition += TransitionTo;
		}

		if (initialNodeState != null) {
			currentNodeState = initialNodeState;
			currentNodeStateName = currentNodeState.Name;
			initialNodeState.Enter();
		}
	}

    public override void _Process(double delta)
    {
		if (currentNodeState != null)
			currentNodeState.OnProcess(delta);
    }

    public override void _PhysicsProcess(double delta)
    {
		if (currentNodeState != null)
			currentNodeState.OnPhysicsProcess(delta);
    }

    public override void _Input(InputEvent @event)
	{
		if (currentNodeState != null)
			currentNodeState.Input(@event);
	}

	public static void TransitionTo(string newNodeName) 
	{
		if (currentNodeStateName == newNodeName)
			return;

		var newNode = nodeStates[newNodeName];

		if (newNode == null)
			return;

		currentNodeState.Exit();
		currentNodeState = newNode;
		currentNodeStateName = currentNodeState.Name;
		currentNodeState.Enter();
	}
}
