using Godot;

public partial class Saw : Path2D
{
	[Export] private float speed = 0.003f;

	private PathFollow2D pathFollow;
	private float direction = 1.0f;
	private AnimatableBody2D sawBody;
	private AnimatedSprite2D visibleSaw;
	
	public override void _Ready()
	{
		pathFollow = GetNode<PathFollow2D>("PathFollow2D");
		visibleSaw = GetNode<AnimatedSprite2D>("PathFollow2D/SawBody/AnimatedSprite2D");
		sawBody = GetNode<AnimatableBody2D>("PathFollow2D/SawBody");
	}

	public override void _PhysicsProcess(double delta)
	{
		pathFollow.ProgressRatio += speed * direction;

		if (pathFollow.ProgressRatio == 0.0f)
			direction = 1.0f;

		if (pathFollow.ProgressRatio == 1.0f)
			direction = -1.0f;

		sawBody.GlobalPosition = visibleSaw.GlobalPosition;

		/* 576 324*/
	}
}
