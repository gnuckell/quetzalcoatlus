class_name FloatRange extends Resource

@export var minimum : float
@export var maximum : float


func _init(__minimum: float = 0.0, __maximum: float = 0.0) -> void:
	minimum = __minimum
	maximum = __maximum


func get_random_value(random: RandomNumberGenerator = null) -> float:
	if random: return random.randf_range(minimum, maximum)
	else: return randf_range(minimum, maximum)
