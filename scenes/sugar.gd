extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $"../Cupboard/AnimatedSprite2D"
@onready var animation_player: AnimationPlayer = $CollisionShape2D/AnimatedSprite2D/AnimationPlayer
@onready var counter: Area2D = $"../Counter"
@onready var counter_sprite_2d: AnimatedSprite2D = $"../Counter/AnimatedSprite2D"

@onready var trash_sprite: AnimatedSprite2D = $"../Trash/CollisionShape2D/AnimatedSprite2D"
@onready var particles: CPUParticles2D = $CPUParticles2D

@onready var sugar_sprite: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var sugar_timer: Timer = $Sugar_Timer




var sugar_is_selected : bool :
	set(value):
		if sugar_is_selected != value:
			sugar_is_selected = value
		if sugar_is_selected:
			sugar_sprite.play("sugar_selected")
			if !sugar_placed:
				counter_sprite_2d.play("glowing")
		else:
			sugar_sprite.play("sugar_closed")
			counter_sprite_2d.play("default")
		if sugar_empty:
			sugar_sprite.play("sugar_open")
		if sugar_has_salt:
			sugar_sprite.play("sugar_closed")



var sugar_placed : bool
var sugar_can_empty : bool
var sugar_empty : bool 
var sugar_has_salt : bool 
var cant_move : bool
var start_pos = Vector2(865,546)
var counter_pos_sugar = Vector2(720,580)
var trash_pos_sugar = Vector2(250,670)

func _ready() -> void:
	sugar_is_selected = false
	sugar_placed = false
	sugar_can_empty = false
	sugar_empty = false
	sugar_has_salt = false
	position = start_pos


func _process(delta: float) -> void:
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		animation_player.play("scale")
		sugar_is_selected = true
		if sugar_placed && sugar_can_empty:
			sugar_sprite.play("sugar_open")
			trash_sprite.play("trash_glowing")
		if sugar_has_salt:
			position = start_pos
			



func _on_counter_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		if sugar_is_selected && !sugar_placed:
			sugar_sprite.play("sugar_closed")
			position = counter_pos_sugar
			sugar_placed = true
			sugar_can_empty = true
			sugar_is_selected = false

func sugar_emptying()->void:
	position = trash_pos_sugar
	rotation_degrees = -85.0
	particles.emitting =true
	sugar_empty = true
	sugar_timer.start()


func _on_trash_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		if sugar_can_empty:
			sugar_emptying()


func _on_sugar_timer_timeout() -> void:
	particles.emitting = false
	position = counter_pos_sugar
	rotation_degrees = 0
	sugar_is_selected = false
	sugar_can_empty = false
	trash_sprite.play("trash_full")
