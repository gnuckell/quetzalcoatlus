extends Area3D

@onready var pawn : Pawn = get_parent()

var selection : Node3D
var selections : Array[Node3D]

func _when_body_entered(body: Node3D) -> void:
	if pawn.behavior.grabber.grabbed_body != null: return
	if body == pawn: return
	selections.push_back(body)
	selection = get_selection()
	
	if body is Pawn:
		body.behavior.entered_selection.emit(pawn)


func _when_body_exited(body: Node3D) -> void:
	if pawn.behavior.grabber.grabbed_body != null: return
	if body == pawn: return
	selections.erase(body)
	selection = get_selection()
	
	if body is Pawn:
		body.behavior.exited_selection.emit(pawn)
	
	
func get_selection() -> Node3D:
	return selections[0] if selections else null
	
