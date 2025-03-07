extends NodeState

@export var hurt_box: Area2D
@export var player_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

var hurt_time: float = 0.3

var hurt_degrees: Dictionary = {
	"sawbody": { "hurt_time": 0.3, "damage": 1 },
	"spikes": { "hurt_time": 0.7, "damage": 1 },
	"spikeball": { "hurt_time": 0.3, "damage": 1 }
}

func enter() -> void:
	animated_sprite_2d.play("hurt")
	hurt_box.set_collision_mask_value(7, false)
	hurt_box.set_collision_mask_value(3, false)
	player_body_2d.set_collision_mask_value(3, false)
	player_body_2d.set_collision_mask_value(4, false)
	player_body_2d.set_collision_mask_value(5, false)
	player_body_2d.set_collision_mask_value(6, false)
	player_body_2d.set_collision_mask_value(7, false)
	player_body_2d.velocity = Vector2.ZERO
	get_tree().create_timer(hurt_time).timeout.connect(func (): transition.emit("IdleState"))
	animated_sprite_2d.rotation = deg_to_rad(270)
	animated_sprite_2d.flip_h = false


func on_physics_process(_delta: float) -> void:
	player_body_2d.velocity = Vector2(-0.5, -0.71) * player_body_2d.HURT_SPEED * 2.0 * _delta
	player_body_2d.velocity += player_body_2d.get_gravity() * _delta


func exit() -> void:
	animated_sprite_2d.stop()
	get_tree().create_tween().tween_property(player_body_2d, "velocity", Vector2.ZERO, 0.4)
	animated_sprite_2d.rotation = deg_to_rad(0)
	hurt_box.set_collision_mask_value(7, true)
	hurt_box.set_collision_mask_value(3, true)
	player_body_2d.set_collision_mask_value(3, true)
	player_body_2d.set_collision_mask_value(4, true)
	player_body_2d.set_collision_mask_value(5, true)
	player_body_2d.set_collision_mask_value(6, true)
	player_body_2d.set_collision_mask_value(7, true)
