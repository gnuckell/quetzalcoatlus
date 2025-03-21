extends PawnSprite

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if self.is_playing_looping_animation:
		self.play(&"walk" if is_moving else &"idle")


func _when_animation_finished() -> void:
	match self.animation:
		&"peck": self.play(&"idle")
