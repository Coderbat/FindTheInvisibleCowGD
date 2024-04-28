extends Node2D

var button = Button.new()
var end_game_image = Sprite2D.new()
var end_game_started = false
var end_game_start_time = 0
var end_game_sound_player = AudioStreamPlayer.new()
@onready
var sound_player = $AudioStreamPlayer2D


func _ready():
	button.set_size(Vector2(100, 50))
	button.set_position(Vector2(randf_range(0, get_viewport().size.x - button.get_size().x), randf_range(0, get_viewport().size.y - button.get_size().y)))
	button.connect("pressed",end_game)
	#button.modulate = Color(1, 1, 1, 0) 
	add_child(button)

	add_child(sound_player)
	sound_player.play()
	end_game_image.texture = preload("res://cow.png")
	end_game_image.position = button.position
	end_game_image.visible = false
	add_child(end_game_image)
	
	end_game_sound_player.stream = preload("res://gameoversound.mp3")
	add_child(end_game_sound_player)

func _process(delta):
	if sound_player.is_playing():
		var button_center = button.get_global_rect().position + button.get_size() / 2
		var distance = button_center.distance_to(get_global_mouse_position())
		var max_distance = sqrt(get_viewport().size.x * get_viewport().size.x + get_viewport().size.y * get_viewport().size.y)
		var volume_ratio = 1 - pow(distance / max_distance, 0.5)
		sound_player.volume_db = linear2db(volume_ratio)
		var speed_ratio = volume_ratio + 0.8  # Adjust this formula as needed
		sound_player.pitch_scale = speed_ratio
	if end_game_started:
		var elapsed_time = Time.get_ticks_msec() - end_game_start_time
		if elapsed_time < 10000:
			var scale = 1 + elapsed_time / 5000.0
			end_game_image.scale = Vector2(scale, scale)
		else:
			go_to_main_menu()


func linear2db(linear):
	if linear == 0:
		return -80
	else:
		return 20 * log(linear) / log(10)
		
func end_game():
	button.visible = false
	end_game_image.visible = true
	end_game_started = true
	end_game_start_time = Time.get_ticks_msec()
	sound_player.stop()
	end_game_sound_player.play()
	
func go_to_main_menu():
	get_tree().change_scene_to_file("res://main.tscn")
