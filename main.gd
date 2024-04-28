extends Control

@onready var start_button = $MarginContainer/VBoxContainer/Button1 as Button
@onready var quit_button = $MarginContainer/VBoxContainer/Button2 as Button
@onready var start_level = preload("res://World.tscn")
@onready var ScoreLabel = $MarginContainer/VBoxContainer/Label2
var save_file = "user://score.save"
var score = 0

func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_exit_pressed)
	load_score()
	ScoreLabel.text = "SCORE: "+str(score)
	
	
func on_start_pressed():
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed():
	get_tree().quit()
	
func load_score():
	var save_data = ConfigFile.new()
	var err = save_data.load(save_file)

	if err == OK:  # If the file loaded successfully
		score = save_data.get_value("score", "value", 0)  # The third parameter is a default value in case the key doesn't exist
	else:
		print("Error loading save file: ", err)
