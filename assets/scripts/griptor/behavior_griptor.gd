extends Behavior

enum {
	WANDERING,
	HUNTING,
	ESCAPING,
	HIDING,
}


func _ready() -> void:
	super._ready()


func _attack() -> void:
	state = HUNTING


func _physics_process_unstunned(delta: float) -> void:
	physics_process_walk_to_target(delta)


func _when_state_changed(value: int) -> void:
	if state == WANDERING: wander()
	else: $wander_timer.stop()

	print("State changed to %s" % state)

	match state:
		WANDERING:
			self.can_attack = true
		HUNTING:
			self.target_node = get_target_baby()
			if self.target_node == null: wander()
		ESCAPING:
			self.target_node = self.home_area
		_: pass


func _when_target_reached() -> void:
	match state:
		HUNTING:
			grabber.grabbed_body = self.target_node
			state = ESCAPING
		ESCAPING:
			if grabber.grabbed_body != null:
				grabber.grabbed_body.queue_free()
				grabber.grabbed_body = null
				state = WANDERING


func get_target_baby() -> Pawn:
	var all_babies := self.get_tree().get_nodes_in_group(&"babies")
	all_babies.shuffle()
	for i in all_babies:
		if i.is_phased: continue
		return i
	return null
