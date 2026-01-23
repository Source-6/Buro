extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_closed: CollisionShape2D = $CollisionShapeClosed
@onready var collision_shape_open_1: CollisionShape2D = $CollisionShapeOpen1
@onready var collision_shape_open_2: CollisionShape2D = $CollisionShapeOpen2



var is_closed : bool

func _ready() -> void:
	is_closed = true

func _process(delta: float) -> void:
	collision_shape_closed.disabled = !is_closed
	collision_shape_open_1.disabled = is_closed
	collision_shape_open_2.disabled = is_closed


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select") && is_closed:
		cupboard_sprite_2d.play("open")  #need to change collision shape (only on the door)
		is_closed = false
	elif Input.is_action_just_pressed("select") :
		cupboard_sprite_2d.play("closed")
		is_closed = true
		
