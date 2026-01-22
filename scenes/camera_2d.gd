extends Camera2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scene_cafet"):
		position.x = 1920
	elif Input.is_action_just_pressed("scene_office"):
		position.x = 0
