class_name EnemyController extends Timer

static var inst : EnemyController

var enemies_sent : int = 0

func _ready() -> void:
	inst = self


func kickstart() -> void:
	if self.is_stopped(): start()


func get_available_attacker() -> Behavior:
	var all_enemies := self.get_tree().get_nodes_in_group(&"enemies")
	all_enemies.shuffle()
	for e in all_enemies:
		if e.can_attack: return e
	return null


func send_new_attacker() -> void:
	var enemy := get_available_attacker()
	if enemy == null: return

	enemy.attack()
	enemies_sent += 1


func _when_timeout() -> void:
	send_new_attacker()
