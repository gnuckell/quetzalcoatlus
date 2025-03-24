extends PawnSprite

var is_escaping : bool

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	animated_sprite.play((&"run_fleeing" if is_escaping else &"run_normal") if is_moving else &"idle")


func _when_behavior_state_changed(value: int) -> void:
	is_escaping = value == 2

