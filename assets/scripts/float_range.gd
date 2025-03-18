class_name FloatRange extends Resource

@export var minimum : float
@export var maximum : float


func _init(__minimum: float = 0.0, __maximum: float = 0.0) -> void:
	minimum = __minimum
	maximum = __maximum


## Returns a random [float] between [member minimum] and [member maximum].
func get_random_value(random: RandomNumberGenerator = null) -> float:
	if random: return random.randf_range(minimum, maximum)
	else: return randf_range(minimum, maximum)


## Returns a [float] with a random sign between [member minimum] and [member maximum].
func get_random_vector1(random: RandomNumberGenerator = null) -> float:
	if random: return random.randf_range(minimum, maximum) * (1.0 if random.randi() % 2 else -1.0)
	else: return randf_range(minimum, maximum) * (1.0 if randi() % 2 else -1.0)


## Returns a [Vector2] with a random direction and a length between [member minimum] and [member maximmum].
func get_random_vector2(random: RandomNumberGenerator = null) -> Vector2:
	if random: return Vector2(get_random_value(random) * (1.0 if random.randi() % 2 else -1.0), get_random_value(random) * (1.0 if random.randi() % 2 else -1.0))
	else: return Vector2(get_random_value() * (1.0 if randi() % 2 else -1.0), get_random_value() * (1.0 if randi() % 2 else -1.0))


## Returns a [Vector3] with a random direction and a length between [member minimum] and [member maximmum].
func get_random_vector3(random: RandomNumberGenerator = null) -> Vector3:
	if random: return Vector3(get_random_value(random) * (1.0 if random.randi() % 2 else -1.0), get_random_value(random) * (1.0 if random.randi() % 2 else -1.0), get_random_value(random) * (1.0 if random.randi() % 2 else -1.0))
	else: return Vector3(get_random_value() * (1.0 if randi() % 2 else -1.0), get_random_value() * (1.0 if randi() % 2 else -1.0), get_random_value() * (1.0 if randi() % 2 else -1.0))

