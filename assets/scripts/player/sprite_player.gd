extends PawnSprite

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if self.is_playing_looping_animation:
		animated_sprite.play(&"walk" if is_moving else &"idle")


func _when_animation_finished() -> void:
	match animated_sprite.animation:
		&"peck": animated_sprite.play(&"idle")
