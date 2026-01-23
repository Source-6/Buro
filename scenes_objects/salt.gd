extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $"../Cupboard/AnimatedSprite2D"
@onready var salt_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var sugar: Area2D = $"../Sugar"
@onready var counter_sprite_2d: AnimatedSprite2D = $"../Counter/AnimatedSprite2D"



var salt_is_selected : bool
var salt_placed : bool
var counter_pos_salt = Vector2(460,580)

func _ready() -> void:
	salt_is_selected = false
	salt_placed = false

func _process(delta: float) -> void:
	if !salt_placed:
		if cupboard_sprite_2d.animation == "closed":
			visible = false
			input_pickable = false
		elif cupboard_sprite_2d.animation == "open":
			visible = true
			input_pickable = true

	if salt_is_selected && !salt_placed:
		counter_sprite_2d.play("glowing")
	else:
		counter_sprite_2d.play("default")



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		salt_sprite_2d.play("salt_selected")
		salt_is_selected = true
		


func _on_counter_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		if salt_is_selected:
			salt_sprite_2d.play("default")
			position = counter_pos_salt
			salt_placed = true
			salt_is_selected = false
