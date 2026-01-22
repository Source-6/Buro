extends Area2D
@onready var cupboard_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_closed: CollisionShape2D = $CollisionShapeClosed
@onready var collision_shape_open_1: CollisionShape2D = $CollisionShapeOpen1
@onready var collision_shape_open_2: CollisionShape2D = $CollisionShapeOpen2



var is_open : bool

func _ready() -> void:
	is_open = false

func _process(delta: float) -> void:
	if !is_open:
		collision_shape_open_1.set_process(false)
		collision_shape_open_2.set_process(false)
		collision_shape_closed.set_process(true)
	elif !is_open:
		collision_shape_closed.set_process(false)
		collision_shape_open_1.set_process(true)
		collision_shape_open_2.set_process(true)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select") && !is_open:
		cupboard_sprite_2d.play("open")  #need to change collision shape (only on the door)
		is_open = true
	elif Input.is_action_just_pressed("select") :
		cupboard_sprite_2d.play("closed")
		is_open = false
		
