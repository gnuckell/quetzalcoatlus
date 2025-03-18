extends Behavior

enum {
	IDLING,
	CAPTURED,
}

const STARVING_WARNING_TIME_REMAINING : float = 30.0

signal when_hungry
signal when_starving
signal when_starved
signal when_fed

var food_eaten : int
var hunger_time_remaining : float = 60.0

var _is_mouth_open : bool
var is_mouth_open : bool :
	get: return _is_mouth_open
	set(value):
		_is_mouth_open = value

		if _is_mouth_open:
			pawn.velocity = Vector3.ZERO
			pawn.walk_vector = Vector3.ZERO

		if state == IDLING:
			pass
			# open or close mouth

func _ready() -> void:
	super._ready()

	wander()


func _physics_process_unstunned(delta: float) -> void:
	if is_mouth_open: return
	match state:
		IDLING: physics_process_walk_to_target(delta)


func _get_wander_position() -> Vector3:
	return get_random_home_position() if is_inside_home else super._get_wander_position()


func _when_state_changed(value: int) -> void:
	if state == IDLING: wander()
	else: $wander_timer.stop()


func _when_entered_selection(other: Pawn) -> void:
	super._when_entered_selection(other)
	if entered_selections.has(Pawn.PLAYER):
		is_mouth_open = true

func _when_exited_selection(other: Pawn) -> void:
	super._when_exited_selection(other)
	if not entered_selections.has(Pawn.PLAYER):
		is_mouth_open = false

#if "hungry": start crying
#elif "in danger" (starving or being eaten): start screaming and display notification
#else (safe): stop making sounds
#
#if "selected to be fed": Stand still.
	#if "completely fed": do nothing or shake head to indicate not hungry. (low priority selection)
	#else: Open mouth wide
#else:
	#if old enough to walk: Wander around aimlessly.
		#if inside nest: choose a location to never leave nest.
		#else: choose a random location.

