extends Area2D
@onready var paper_plane: AnimatedSprite2D = $CollisionShape2D/PaperPlane


var max_fold = 2
var folded : bool
var plane_is_selected : bool
var throwed : bool


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
		#(add anim scale)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("fold"):
		paper_plane.frame +=1
		if paper_plane.frame == max_fold:
			folded = true
			if Input.is_action_just_pressed("fold"):
				plane_is_selected = true
