extends Area2D
@onready var todo_closeup: TextureRect = $"../TodoCloseup"





func _ready() -> void:
	todo_closeup.visible = false


func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("select") :
		if !todo_closeup.visible:
			todo_closeup.visible = true
		elif todo_closeup.visible:
			todo_closeup.visible = false
		
