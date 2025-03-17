class_name Behavior extends NavigationAgent3D

const TARGET_POSITION_MAX_ATTEMPTS : int = 8

signal state_changed(value: int)

@export var home_area : Area3D

@export_category("Wander")
@export var wander_distance_range : FloatRange
@export var wander_time_range : FloatRange
@export var home_radius : float = 5.0

var _target_node : Node3D
var target_node : Node3D :
	get: return _target_node
	set(value):
		if _target_node == value: return
		_target_node = value
		
		if _target_node:
			$nav_timer.timeout.connect(update_target_position)
		else:
			$nav_timer.timeout.disconnect(update_target_position)

var is_inside_home : bool :
	get: return home_radius != null and is_position_inside_home(pawn.global_position)
var is_stunned : bool

var _state : int
var state : int :
	get: return _state
	set(value):
		if _state == value: return
		_state = value
		state_changed.emit(_state)


@onready var pawn : Pawn = self.get_parent()


func _ready() -> void:
	if home_area:
		home_area.body_entered.connect(_when_entered_home_area)
		home_area.body_exited.connect(_when_exited_home_area)
		


func _when_state_changed(value: int) -> void: pass


func _when_entered_home_area(body: Node3D) -> void:
	if body != pawn: return
	is_inside_home = true
func _when_exited_home_area(body: Node3D) -> void:
	if body != pawn: return
	is_inside_home = false


func _physics_process(delta: float) -> void:
	if is_stunned: return
	_physics_process_unstunned(delta)
func _physics_process_unstunned(delta: float) -> void: pass


func physics_process_walk_to_target(delta: float) -> void:
	pawn.walk_vector = get_walk_direction()

func wander():
	if wander_time_range == null: return
	
	self.target_node = null
	self.target_position = _get_wander_position()
	
	$wander_timer.wait_time = wander_time_range.get_random_value()
	$wander_timer.start()
	
	
func get_walk_direction() -> Vector3:
	return (self.get_next_path_position() - pawn.global_position).normalized() * Vector3(1, 0, 1)


func _get_wander_position() -> Vector3:
	return get_random_nearby_position()
	

func get_random_nearby_position() -> Vector3:
	if wander_distance_range == null: return self.pawn.global_position
	
	var result : Vector3
	var map := self.pawn.get_world_3d().navigation_map

	for i in TARGET_POSITION_MAX_ATTEMPTS:
		result = self.pawn.global_position + wander_distance_range.get_random_vector3()
		var closest := NavigationServer3D.map_get_closest_point(map, result)
		var delta := (closest - result) * Vector3(1, 0, 1)
		if delta.is_zero_approx(): return closest
	return result


func get_random_home_position() -> Vector3:
	if wander_distance_range == null: return self.pawn.global_position
	
	var result : Vector3
	var map := self.pawn.get_world_3d().navigation_map
	
	for i in TARGET_POSITION_MAX_ATTEMPTS:
		result = self.pawn.global_position + wander_distance_range.get_random_vector3()
		var closest := NavigationServer3D.map_get_closest_point(map, result)
		if is_position_inside_home(result): return closest
	return get_random_nearby_position()
	
	
func is_position_inside_home(pos: Vector3) -> bool:
	var delta := home_area.global_position - pos
	return delta.length() < home_radius


func wait(delay : float) :
	await get_tree().create_timer(delay).timeout


func update_target_position():
	self.target_position = target_node.global_position


func _when_target_reached() -> void:
	#print("target reached!")
	pass
