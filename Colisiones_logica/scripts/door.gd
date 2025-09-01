extends Area2D

@export var closed_texture: Texture2D
@export var open_texture: Texture2D

var is_open = false

signal player_success

func _ready() -> void:
	close()

func open():
	$Sprite2D.texture = open_texture
	is_open = true
	
func close():
	$Sprite2D.texture = closed_texture
	is_open = false
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and is_open:
		player_success.emit()
