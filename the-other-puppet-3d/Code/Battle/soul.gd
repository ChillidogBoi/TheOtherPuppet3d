extends CharacterBody2D

@onready var tp_indicator = $TP_indicator

@export var gravity_mode := false
var parent: Node

const SPEED = 80.0
const JUMP_VELOCITY = -90.0

var hit_by: Array[Bullet]

func _ready():
	parent = get_parent()

func _physics_process(delta):
	if gravity_mode: gravity_soul(delta)
	else: normal_soul()

func normal_soul():
	var direction = Input.get_vector("strafe_left", "strafe_right", "move_forwards", "move_backwards")
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()

func gravity_soul(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("strafe_left", "strafe_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hurtbox_entered(body):
	parent.emit_signal("took_damage", body.damage)
	print(body.damage, " damage")
	if body.destroy_on_touch: body.queue_free()
	else: hit_by.append(body)


func _on_tp_box_body_exited(body):
	tp_indicator.visible = false
	if hit_by.has(body): return
	parent.emit_signal("gained_tp", body.tension_points)


func _on_tp_box_body_entered(body):
	tp_indicator.visible = true
