class_name PawnSprite extends Sprite3D

@export var animated_sprite : AnimatedSprite2D

@onready var pawn : Pawn = get_parent()

var turned : bool :
	get: return flip_h
	set(value):
		if (flip_h == value): return
		self.recursive_flip()
		self.look_at(self.global_position + (Vector3.BACK if self.flip_h else Vector3.FORWARD))


var is_moving : bool :
	get: return pawn.velocity.length_squared() > 0.1


var is_playing_looping_animation : bool :
	get: return animated_sprite.sprite_frames.get_animation_loop(animated_sprite.animation)


func _physics_process(delta: float) -> void:
	if abs(pawn.velocity.x) > 0.1:
		turned = pawn.velocity.x < 0.0


func recursive_flip() -> void:
	self.flip_h = not self.flip_h
	self.offset = self.offset * Vector2(-1, 1)
	for child in self.get_children(): if child is PawnSprite: child.recursive_flip()


func _when_behavior_state_changed(value: int) -> void:
	pass # Replace with function body.


func _when_animation_finished() -> void:
	pass # Replace with function body.
