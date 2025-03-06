using Godot;

public partial class Trampoline : RigidBody2D
{
	public AnimationPlayer animationPlayer;
	public Area2D propelArea;
	
	[Export]
	public float bounceVelocity = -1.2f;

	public override void _Ready() {
		animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
		propelArea = GetNode<Area2D>("BounceArea2D");

		animationPlayer.Play("idle");

		propelArea.BodyEntered += (Node2D body) => {

			switch (body) {
				case CharacterBody2D:
					var velocity = ((CharacterBody2D)body).Velocity;
					velocity.Y = bounceVelocity;
					((CharacterBody2D)body).Velocity = velocity;
					animationPlayer.Play("default");
					break;

				case RigidBody2D:
					((RigidBody2D)body).ApplyForce(Vector2.Up * bounceVelocity);
					animationPlayer.Play("default");
					break;

				default:
					break;
			};
		};
	
	}
}
