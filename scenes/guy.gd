extends CharacterBody2D

@onready var guy_sprite: AnimatedSprite2D = $guy_sprite
@onready var animation_player: AnimationPlayer = $guy/AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var mug: Area2D = $"../Mug"
@onready var paper_plane: Area2D = $"../PaperPlane"




enum States {IDLE, WALK, MUG_HITTING, PLANE_HITTING}
var state : States = States.IDLE


var MAXRIGHT = 1700
var MAXLEFT =50
var MAXANGERLVL = 100


@export var amplitude : float
@export var speed : float 
var pref_speed : float
var time = 0.0


var has_been_hit_mug : bool
var has_been_hit_plane : bool
var anger_mug = 10
var anger_plane = 5
var can_be_hit_mug : bool
var can_be_hit_plane : bool


func _ready() -> void:
	progress_bar.value = 0
	has_been_hit_mug = false
	has_been_hit_plane = false
	can_be_hit_mug = false
	can_be_hit_plane = false
	pref_speed = speed
	guy_sprite.play("idle")

func _process(delta: float) -> void:
	
	#replaced lefttoright()
	time += delta*speed
	position.x = 1000 + (sin(time) * amplitude) 
	if cos(time)> 0.0 : 
		guy_sprite.flip_h = true
	else :
		guy_sprite.flip_h = false

	animate_collision_shape()




func animate_collision_shape() -> void:
	if position.x >= 1500:
		collision_shape_2d.scale.y = 2.5
	else :
		collision_shape_2d.scale.y = 1


func add_anger(anger_num : int) -> void:
		progress_bar.value += anger_num
		speed = 0
		if has_been_hit_mug :
			guy_sprite.play("mug_hitting")
			timer.start()
		if has_been_hit_plane:
			guy_sprite.play("plane_hitting")
			timer.start()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("throw"):
		if  is_instance_valid(mug) && mug.mug_is_selected :
			paper_plane.plane_is_selected = false
			mug.throw_mug()
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
	guy_sprite.play("idle")
	speed = pref_speed
