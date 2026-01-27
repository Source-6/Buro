extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $"../Cupboard/AnimatedSprite2D"
@onready var salt_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var sugar: Area2D = $"../Sugar"
@onready var counter_sprite_2d: AnimatedSprite2D = $"../Counter/AnimatedSprite2D"
@onready var salt_timer: Timer = $Salt_Timer
@onready var particles: CPUParticles2D = $CPUParticles2D




var salt_is_selected : bool :
	set(value):
		if salt_is_selected != value:
			salt_is_selected = value
		if salt_is_selected:
			salt_sprite_2d.play("salt_selected")
			if !salt_placed:
				counter_sprite_2d.play("glowing")
		else:
			salt_sprite_2d.play("default")
			counter_sprite_2d.play("default")


var salt_placed : bool
var salt_empty :bool

var start_pos = Vector2(430,113)
var counter_pos_salt = Vector2(460,580)
var fill_pos_salt = Vector2(640,500)

func _ready() -> void:
	position = start_pos
	salt_is_selected = false
	salt_placed = false
	salt_empty = false

func _process(delta: float) -> void:
	if !salt_placed:
		if cupboard_sprite_2d.animation == "closed":
			visible = false
			input_pickable = false
		elif cupboard_sprite_2d.animation == "open":
			visible = true
			input_pickable = true



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		salt_is_selected = true
		if salt_placed && sugar.sugar_empty:
			fill_sugar_with_salt()
		if salt_placed && sugar.sugar_has_salt :
			position = start_pos
			salt_placed = false
			salt_is_selected = false
			


func fill_sugar_with_salt()-> void:
	position = fill_pos_salt
	rotation_degrees = 80
	particles.emitting = true
	sugar.sugar_empty = false
	salt_timer.start()


func _on_counter_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		if salt_is_selected && !salt_placed:
			position = counter_pos_salt
			salt_placed = true
			salt_is_selected = false


func _on_salt_timer_timeout() -> void:
	position = counter_pos_salt
	rotation_degrees = 0
	salt_is_selected = false
	particles.emitting = false
	sugar.sugar_has_salt = true
