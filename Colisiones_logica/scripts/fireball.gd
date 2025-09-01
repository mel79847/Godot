extends Area2D

@export var direction: Vector2 = Vector2.ZERO
@export var speed: float = 0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
