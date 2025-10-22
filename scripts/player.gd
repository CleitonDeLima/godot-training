extends Node2D

var direction: Vector2 = Vector2(1, 1)


func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += direction * 20
	
	if Input.is_action_just_pressed("ui_accept"):
		print("Space ok")
