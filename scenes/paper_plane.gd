extends Area2D
@onready var paper_plane: AnimatedSprite2D = $CollisionShape2D/PaperPlane
@onready var animation_player: AnimationPlayer = $CollisionShape2D/PaperPlane/AnimationPlayer


var max_fold = 2
var click_counter = 0
var folded : bool
@export var plane_is_selected : bool
@export var throwed : bool


func _ready() -> void:
	folded = false
	plane_is_selected = false
	throwed = false


func _process(delta: float) -> void:
	pass

func throw_plane()-> void:
	if plane_is_selected:
		throwed = true
		plane_is_selected = false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("fold"):
		click_counter +=1
		paper_plane.frame = click_counter
		if click_counter == max_fold:
			folded = true
		if click_counter > max_fold:
			plane_is_selected = true
			animation_player.play("scalePlane")
