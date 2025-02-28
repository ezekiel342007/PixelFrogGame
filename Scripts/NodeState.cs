using Godot;

public partial class NodeState: Node
{

	[Signal]
	public delegate void TransitionEventHandler(string NewState);

	public virtual void Enter() {}

	public virtual void Input(InputEvent @event) {}

	public virtual void OnProcess(double delta) {}

	public virtual void OnPhysicsProcess(double delta) {}

	public virtual void Exit() {}
}
