extends Node3D

var _grabbed_body : PhysicsBody3D
var grabbed_body : PhysicsBody3D :
	get: return _grabbed_body
	set(value):
		if _grabbed_body == value: return

		if _grabbed_body is Pawn:
			var pos : Vector3 = _grabbed_body.global_position
			self.remove_child(_grabbed_body)
			self.get_tree().root.add_child(_grabbed_body)
			_grabbed_body.global_position = pos
			_grabbed_body.is_phased = false

		_grabbed_body = value

		if _grabbed_body is Pawn:
			_grabbed_body.get_parent().remove_child(_grabbed_body)
			self.add_child(_grabbed_body)
			_grabbed_body.position = Vector3.ZERO
			_grabbed_body.is_phased = true
