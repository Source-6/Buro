extends Area2D
@onready var animation_player: AnimationPlayer = $CollisionShape2D/Mug/AnimationPlayer
@onready var guy_charac_2d: CharacterBody2D = $"../GuyCharacter2D"



@export var can_be_used : bool
@export var throwed : bool

func _ready() -> void:
	can_be_used = false
	throwed = false

func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		animation_player.play("scaleClicked")
		can_be_used = true
		print("clicked")
		#get_viewport().set_input_as_handled()


func throw_stuff()-> void:
	if can_be_used:
		print("throw") 
		throwed = true
		can_be_used = false
