extends Behavior

signal pecked

func _ready() -> void:
	super._ready()
	Pawn.PLAYER = self.pawn


func _physics_process_unstunned(delta: float) -> void:
	var input : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	pawn.walk_vector = Vector3(input.x, 0.0, input.y)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		interact()


func interact() -> void:
	if is_stunned: return
	pecked.emit()

