extends Node2D

@onready var door: Area2D = $Door
@onready var player = $Player

func _ready() -> void:
	$Key.collected.connect(on_key_collected)
	$Gem.collected.connect(on_gem_collected)
	$Door.player_success.connect(on_player_success)
	player.auch.connect(on_player_damaged)
	
func on_key_collected():
	player.has_key = true
	$Door.open()
	
func on_gem_collected():
	player.get_gem();
	
func on_player_success():
	$SuccessLabel.visible = true

func on_player_damaged():
	$HPLabel.text = "VIDA: %d" %player.hp
	if player.hp <= 0:
		$SuccessLabel.text = "ups, moriste :( todo por no controlar mi m* forma de beber"
		$SuccessLabel.visible = true
		get_tree().paused = true
