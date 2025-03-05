using Godot;

public partial class Trampoline : RigidBody2D
{
	public AnimationPlayer animationPlayer;
	public Area2D propelArea;
	
	[Export]
	public float bounceVelocity = -700.0f;

	public override void _Ready() {
		animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
		propelArea = GetNode<Area2D>("BounceArea2D");

		propelArea.BodyEntered += (Node2D body) => {
			animationPlayer.Play("default");

			switch (body) {
				case CharacterBody2D:
					var velocity = ((CharacterBody2D)body).Velocity;
					velocity.Y = bounceVelocity;
					((CharacterBody2D)body).Velocity = velocity;
					break;

				case RigidBody2D:
					((RigidBody2D)body).ApplyForce(Vector2.Up * bounceVelocity);
					break;

				default:
					break;
			};
		};
	
	}
}
