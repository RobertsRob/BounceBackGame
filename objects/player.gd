extends CharacterBody2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_text: Label = $Camera2D/HealthText

const SPEED = 500.0
const JUMP_VELOCITY = -700.0

@export var health: int = 100
@export var died: bool = false

@export var bulletScene: PackedScene

func take_damage(damage: int) -> void:
	if health > damage:
		health = health - damage
	elif not died:
		died = true
		health = 0
		animated_sprite_2d.play("dies")
		timer.start()

	print(health)

func _process(delta: float) -> void:
	health_text.text = "Health: " + str(health) + "\n Coins: " + str(Global.coins)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()
			var direction = (mouse_pos - global_position).normalized()
			var bullet = bulletScene.instantiate()
			get_tree().current_scene.add_child(bullet)
			bullet.global_position = global_position
			bullet.set_dir(direction)
