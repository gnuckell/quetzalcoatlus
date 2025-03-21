extends Behavior


func _ready() -> void:
	super._ready()
	wander()


func _physics_process_unstunned(delta: float) -> void:
	physics_process_walk_to_target(delta)
