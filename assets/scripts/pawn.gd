class_name Pawn extends CharacterBody3D

@export_range(0.0, 1.0, 0.1, "or_greater") var walk_accel : float = 0.5
@export_range(0.0, 1.0) var walk_damping : float = 0.1
#@export var push_priority : int

var temp_collision_layer : int
var temp_collision_mask : int
var _is_phased : bool
## When phased, a pawn has no collision and does not use physics.
var is_phased : bool : 
	get: return _is_phased
	set(value):
		if _is_phased == value: return
		_is_phased = value
		
		self.axis_lock_linear_x = _is_phased
		self.axis_lock_linear_y = _is_phased
		self.axis_lock_linear_z = _is_phased
		
		if _is_phased:
			temp_collision_layer = self.collision_layer
			temp_collision_mask = self.collision_mask
			self.collision_layer = 0
			self.collision_mask = 0
		else:
			self.collision_layer = temp_collision_layer
			self.collision_mask = temp_collision_mask

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
	

	
