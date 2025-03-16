class_name Pawn extends CharacterBody3D

@export_range(0.0, 1.0, 0.1, "or_greater") var walk_accel : float = 0.5
@export_range(0.0, 1.0) var walk_damping : float = 0.1
#@export var push_priority : int

var walk_vector : Vector3

var global_position_flat : Vector3 :
	get: return Vector3(self.global_position.x, 0.0, self.global_position.z)

var velocity_flat : Vector3 :
	get: return Vector3(self.velocity.x, 0.0, self.velocity.z)
	set(value): self.velocity = Vector3(value.x, self.velocity.y, value.z)

func _physics_process(delta: float) -> void:
	velocity -= velocity_flat * walk_damping
	velocity += walk_vector * walk_accel
	
	if not is_on_floor():
		velocity += ProjectSettings.get_setting("physics/3d/default_gravity_vector") * ProjectSettings.get_setting("physics/3d/default_gravity")
	
	self.move_and_slide()
