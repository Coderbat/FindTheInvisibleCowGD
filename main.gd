extends Node2D

var play_button = Button.new()
var quit_button = Button.new()

func _ready():
	play_button.text = "Play"
	play_button.set_size(Vector2(100, 50))
	play_button.connect("pressed", _on_play_button_pressed)
	add_child(play_button)

	quit_button.text = "Quit"
	quit_button.set_size(Vector2(100, 50))
	quit_button.connect("pressed", _on_quit_button_pressed)
	add_child(quit_button)

	await get_viewport().size_changed
	_position_buttons()

func _position_buttons():
	play_button.set_position(Vector2(get_viewport().size.x / 2 - play_button.get_size().x / 2, get_viewport().size.y / 2 - play_button.get_size().y * 2))
	quit_button.set_position(Vector2(get_viewport().size.x / 2 - quit_button.get_size().x / 2, get_viewport().size.y / 2))

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://World.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
