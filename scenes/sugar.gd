extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $"../Cupboard/AnimatedSprite2D"
@onready var animation_player: AnimationPlayer = $CollisionShape2D/AnimatedSprite2D/AnimationPlayer
@onready var counter: Area2D = $"../Counter"
@onready var counter_sprite_2d: AnimatedSprite2D = $"../Counter/AnimatedSprite2D"

@onready var sugar_sprite: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D




var sugar_is_selected : bool
var sugar_placed : bool
var counter_pos_sugar = Vector2(720,580)

func _ready() -> void:
	sugar_is_selected = false
	sugar_placed = false


func _process(delta: float) -> void:
	if sugar_is_selected && !sugar_placed:
		print("wow")
		counter_sprite_2d.play("glowing")
	else:
		counter_sprite_2d.play("default")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		animation_player.play("scale")
		sugar_sprite.play("sugar_selected")
		sugar_is_selected = true


func _on_counter_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		if sugar_is_selected:
			sugar_sprite.play("sugar_closed")
			position = counter_pos_sugar
			sugar_placed = true
			sugar_is_selected = false
			
