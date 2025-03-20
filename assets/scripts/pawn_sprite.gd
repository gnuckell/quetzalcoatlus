class_name PawnSprite extends AnimatedSprite3D

@onready var pawn : Pawn = get_parent()

var turned : bool :
	get: return flip_h
	set(value):
		if (flip_h == value): return
		recursive_flip(self)
		self.look_at(self.global_position + (Vector3.BACK if self.flip_h else Vector3.FORWARD))


func _physics_process(delta: float) -> void:
	if abs(pawn.velocity.x) > 0.1:
		turned = pawn.velocity.x < 0.0


func recursive_flip(sprite: SpriteBase3D) -> void:
	sprite.flip_h = not sprite.flip_h
	sprite.offset = sprite.offset * Vector2(-1, 1)
	for child in sprite.get_children(): if child is SpriteBase3D: recursive_flip(child)


func _when_behavior_state_changed(value: int) -> void:
	pass # Replace with function body.


func _when_animation_finished() -> void:
	pass # Replace with function body.
