extends BattleState

var next_state: String
var target: PartyCombatant
@onready var TP_bar = $"../../TP/ProgressBar"
@onready var TP_label = $"../../TP/Label"


func _ready():
	next_state = CURRENT_STATE_IS_CORRECT

func enter_function():
	next_state = CURRENT_STATE_IS_CORRECT
	
	print(Party.party_turn)
	
	target = Party.party.pick_random()
	var choice = Party.enemy_party.pick_random().attacks.pick_random()
	var bullet_pattern = choice.instantiate()
	get_parent().get_parent().add_child(bullet_pattern)
	bullet_pattern.position = get_parent().get_parent().size / 2.0
	
	bullet_pattern.took_damage.connect(deal_damage)
	bullet_pattern.gained_tp.connect(add_tp)
	
	await bullet_pattern.ended
	bullet_pattern.queue_free()
	
	next_state = "PartyTurn"

func correct_state_test(_inputs:int) -> String:
	return next_state

func deal_damage(damage: int):
	target.current_HP -= clamp(damage - target.current_defense, 0, 2147483645)
	

func add_tp(tension: int):
	TP_bar.value += tension
	TP_label.text = str("\nT\nP\n", str(TP_bar.value).get_slice(".", 0), "\n%")
