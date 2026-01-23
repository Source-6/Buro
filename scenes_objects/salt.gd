extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $"../Cupboard/AnimatedSprite2D"
@onready var salt_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var sugar: Area2D = $"../Sugar"
@onready var counter_sprite_2d: AnimatedSprite2D = $"../Counter/AnimatedSprite2D"
@onready var salt_timer: Timer = $Salt_Timer
@onready var particles: CPUParticles2D = $CPUParticles2D




var salt_is_selected : bool
var salt_placed : bool
var salt_empty :bool
var counter_pos_salt = Vector2(460,580)
var fill_pos_salt = Vector2(640,500)

func _ready() -> void:
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
	if !salt_is_selected:
		salt_sprite_2d.play("default")

	if salt_is_selected && !salt_placed:
		counter_sprite_2d.play("glowing")
	else:
		counter_sprite_2d.play("default")



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		salt_sprite_2d.play("salt_selected")
		salt_is_selected = true
		if sugar.sugar_empty :
			fill_sugar_with_salt()

func fill_sugar_with_salt()-> void:
	position = fill_pos_salt
	rotation_degrees = 80
	particles.emitting = true
	salt_timer.start()
	

func _on_counter_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		if salt_is_selected:
			salt_sprite_2d.play("default")
			position = counter_pos_salt
			salt_placed = true
			salt_is_selected = false


func _on_salt_timer_timeout() -> void:
	position = counter_pos_salt
	rotation_degrees = 0
	salt_is_selected = false
	particles.emitting = false
	
