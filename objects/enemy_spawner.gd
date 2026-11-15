extends Node2D

@export var right = 2000
@export var left = -500

@export var enemyPacked: PackedScene
@export var player: CharacterBody2D

func _on_timer_timeout() -> void:
	
	var enemy = enemyPacked.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.set_pos(Vector2(randf_range(left, right), 50))
	
	
