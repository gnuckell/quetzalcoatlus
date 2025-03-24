extends PawnSprite

var grown : bool


func _ready() -> void:
	animated_sprite.play(&"idle")


func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	# if is_playing_looping_animation:
	var anim_name : StringName = &"idle"
	# var anim_name : StringName = &"walk" if is_moving else &"idle"


	if pawn.grabber and pawn.grabber.species == &"griptor": anim_name = &"scream"
	elif pawn.behavior.is_mouth_open: anim_name = &"whine"


	if grown and self.sprite_frames.has_animation(anim_name + &"_grown"):
		anim_name += &"_grown"

	animated_sprite.play(anim_name)


func _when_animation_finished() -> void:
	match animated_sprite.animation:
		&"gulp": animated_sprite.play(&"idle")