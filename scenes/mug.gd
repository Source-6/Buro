extends Area2D
@onready var animation_player: AnimationPlayer = $CollisionShape2D/Mug/AnimationPlayer
@onready var guy_charac_2d: CharacterBody2D = $"../GuyCharacter2D"



@export var mug_is_selected : bool
@export var throwed : bool

func _ready() -> void:
	mug_is_selected = false
	throwed = false

func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select"):
		animation_player.play("scaleClicked")
		mug_is_selected = true



func throw_stuff()-> void:
	if mug_is_selected:
		print("throw") 
		throwed = true
		mug_is_selected = false
