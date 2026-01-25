extends Area2D
@onready var animation_player: AnimationPlayer = $CollisionShape2D/Mug/AnimationPlayer
@onready var mug_sprite: AnimatedSprite2D = $CollisionShape2D/Mug



@export var mug_is_selected : bool
@export var throwed : bool

var mouse_in : bool

func _ready() -> void:
	mug_is_selected = false
	throwed = false
	mouse_entered.connect(func(): mouse_in = true)
	mouse_exited.connect(func(): mouse_in = false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		if mouse_in:
			animation_player.play("scaleClicked")
			mug_is_selected = true
			mug_sprite.play("selected")
		else :
			mug_is_selected = false
			mug_sprite.play("unselected")


func throw_mug()-> void:
	if mug_is_selected:
		print("throw") 
		throwed = true
		mug_is_selected = false
		
