extends Node2D
@onready var game_timer: Timer = $Game_Timer
@onready var show_timer: Label = $show_timer


var min :float
var sec :float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	min = floor(game_timer.time_left / 60.0)
	sec = fmod(game_timer.time_left,60.0)
	transform_time()


func transform_time()-> void :
	show_timer.text = "%02d : %02d" % [min, sec]


func _on_game_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/gameover.tscn")
