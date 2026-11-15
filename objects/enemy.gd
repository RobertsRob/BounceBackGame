extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -700.0

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := 0
	if player.global_position.x > global_position.x:
		direction = 1
	else:
		direction = -1
		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(20)
	if body.has_method("bullet"):
		queue_free()

func set_pos(pos: Vector2):
	global_position = pos
