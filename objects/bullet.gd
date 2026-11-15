extends CharacterBody2D

@export var speed = 300
@export var direction = Vector2(1, 0)

func _process(delta: float) -> void:
	global_position += direction * speed * delta
	
func set_dir(dir: Vector2):
	direction = dir
	global_rotation = dir.angle()
	
func bullet():
	pass
