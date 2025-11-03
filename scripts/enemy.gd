extends Node2D

@export var speed: float = 0.0
@export var hp: int = 10
@export var size: Vector2 = Vector2(30, 30)

func _ready():
	# opcional: cada inimigo pode ter cor ou tamanho aleatório
	var rect = $ColorRect
	rect.size = size
	rect.color = Color(1, 0, 0)
	add_to_group("enemies")

func take_damage(amount: int):
	hp -= amount
	print('hp', hp)
	if hp <= 0:
		queue_free()  # remove o inimigo da tela
