extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Button1 as Button
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Button2 as Button
@onready var start_level = preload("res://World.tscn")

func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_exit_pressed)
	
	
func on_start_pressed():
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed():
	get_tree().quit()
