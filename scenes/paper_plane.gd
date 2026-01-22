extends Area2D
@onready var paper_plane: AnimatedSprite2D = $CollisionShape2D/PaperPlane
@onready var animation_player: AnimationPlayer = $CollisionShape2D/PaperPlane/AnimationPlayer


var max_fold = 2
var click_counter = 0
var folded : bool
@export var plane_is_selected : bool
@export var throwed : bool

var mouse_in : bool

func _ready() -> void:
	folded = false
	plane_is_selected = false
	throwed = false
	mouse_entered.connect(func(): mouse_in = true)
	mouse_exited.connect(func(): mouse_in = false)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fold"):
		if mouse_in:
			click_counter +=1
			paper_plane.frame = click_counter
			if click_counter == max_fold:
				folded = true
			if click_counter > max_fold:
				plane_is_selected = true
				animation_player.play("scalePlane")
		else : 
			plane_is_selected = false
			
	if plane_is_selected:
		paper_plane.play("selected")
	else: 
		paper_plane.play("folding")
		paper_plane.frame = click_counter

func throw_plane()-> void:
	if plane_is_selected:
		throwed = true
		plane_is_selected = false
		click_counter = 0
