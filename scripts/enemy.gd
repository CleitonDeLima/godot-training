extends Node2D

@export var speed: float = 0.0
@export var hp: int = 10
@export var size: Vector2 = Vector2(30, 30)
@onready var damage_numbers_origin: Node2D = $DamageNumbersOrigin

func _ready() -> void:
	# opcional: cada inimigo pode ter cor ou tamanho aleatório
	var rect: ColorRect = $ColorRect
	rect.size = size
	rect.color = Color(1, 0, 0)
	add_to_group("enemies")

func take_damage(amount: int) -> void:
	hp -= amount
	DamageNumbers.display_number(amount, damage_numbers_origin.global_position)
	
	if hp <= 0:
		Global.score += 1
		queue_free()  # remove o inimigo da tela
