extends CharacterBody2D
@onready var guy: AnimatedSprite2D = $guy
@onready var animation_player: AnimationPlayer = $guy/AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var mug_timer: Timer = $MugTimer
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var mug_area_2d: Area2D = $"../MugArea2D"

@export var has_been_hit : bool
@export var actual_speed : float 
var old_speed : float
var old_flip : bool
var can_be_hit : bool
var MAXRIGHT = 1700
var MAXLEFT =50
var MAXANGERLVL = 100





func _ready() -> void:
	progress_bar.value = 0
	has_been_hit = false
	can_be_hit = false
	guy.play("iddle")

func _process(delta: float) -> void:
	leftToRight(delta)
	animate_collision_shape()


func leftToRight(delta :float) -> void:
	if position.x >= MAXRIGHT:
		actual_speed = -3
		guy.flip_h = !guy.flip_h
	elif position.x <= MAXLEFT:   #a changer parce que c'est psa beau
		actual_speed = 3
		guy.flip_h = !guy.flip_h
	position.x += actual_speed

func animate_collision_shape() -> void:
	if position.x >= 1500:
		collision_shape_2d.scale.y = 2.5
	else :
		collision_shape_2d.scale.y = 1


func add_anger(anger_num : int) -> void:
		progress_bar.value += anger_num
		if has_been_hit :
			guy.play("mug_hitting")
			mug_timer.start()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("throw") && is_instance_valid(mug_area_2d):
		mug_area_2d.throw_stuff()
		if  mug_area_2d.throwed:
			has_been_hit = true
			add_anger(10)
			mug_area_2d.queue_free()


func _on_timer_timeout() -> void:
	guy.play("iddle")
