extends "res://assets/scripts/reach_area.gd"

@onready var selection_marker : Node3D = $shape/selection_marker


func _physics_process(delta: float) -> void:
	var input : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input.is_zero_approx(): return
	input = input.normalized()
	self.rotation = Vector3.UP * atan2(-input.y, input.x)


func _when_body_entered(body: Node3D) -> void:
	super._when_body_entered(body)
	refresh_selection_marker()


func _when_body_exited(body: Node3D) -> void:
	super._when_body_exited(body)
	refresh_selection_marker()


func refresh_selection_marker() -> void:
	selection_marker.visible = selection != null
	selection_marker.get_parent().remove_child(selection_marker)
	(selection if selection != null else $shape).add_child(selection_marker)


func peck() -> void:
	if pawn.behavior.grabber.grabbed_body == null:
		if selection == null: return

		if selection is Pawn:
			var temp = selection
			_when_body_exited(selection)
			pawn.behavior.grabber.grabbed_body = temp
	else:
		pawn.behavior.grabber.grabbed_body = null


func is_valid_selection(body: Node3D) -> bool:
	if body is Pawn:
		match body.species:
			&"baby", &"marmot": return true
			_: return false
	return super.is_valid_selection(body)
