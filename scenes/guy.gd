extends CharacterBody2D
@onready var guy: AnimatedSprite2D = $guy
@onready var animation_player: AnimationPlayer = $guy/AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var mug_timer: Timer = $MugTimer
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var mug: Area2D = $"../MugArea2D"
@onready var paper_plane: Area2D = $"../PaperPlaneArea2D"

var MAXRIGHT = 1700
var MAXLEFT =50
var MAXANGERLVL = 100

@export var actual_speed : float 

var has_been_hit_mug : bool
var has_been_hit_plane : bool
var anger_mug = 10
var anger_plane = 5
var old_speed : float
var old_flip : bool
var can_be_hit_mug : bool
var can_be_hit_plane : bool


func _ready() -> void:
	progress_bar.value = 0
	has_been_hit_mug = false
	has_been_hit_plane = false
	can_be_hit_mug = false
	can_be_hit_plane = false
	guy.play("iddle")

func _process(delta: float) -> void:
	leftToRight(delta)
	animate_collision_shape()
	print("mug : ",mug.mug_is_selected)
	print("plane : ", paper_plane.plane_is_selected)


func leftToRight(delta :float) -> void:
	if position.x >= MAXRIGHT:
		actual_speed = -3
		guy.flip_h = !guy.flip_h
	elif position.x <= MAXLEFT:   #a changer parce que c'est pas beau
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
		if has_been_hit_mug :
			guy.play("mug_hitting")
			mug_timer.start()
		if has_been_hit_plane:
			guy.play("plane_hitting")
			mug_timer.start()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("throw"):
		if  is_instance_valid(mug) && mug.mug_is_selected :
			paper_plane.plane_is_selected = false
			mug.throw_stuff()
			if  mug.throwed:
				has_been_hit_mug = true
				add_anger(anger_mug)
				mug.queue_free()
			mug.mug_is_selected = false
			has_been_hit_mug = false
		elif paper_plane.plane_is_selected && is_instance_valid(paper_plane):
			if is_instance_valid(mug) :
				mug.mug_is_selected = false
			paper_plane.throw_plane()
			if paper_plane.throwed:
				has_been_hit_plane = true
				add_anger(anger_plane)
				#need to del plane and selected = false




func _on_timer_timeout() -> void:
	guy.play("iddle")
