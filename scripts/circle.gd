extends Node2D

@export var radius: float = 30.0
@export var color: Color = Color(1, 1, 1, 0.3)

# ataque
@export var attack_interval: float = 2.0   # tempo entre ataques
@export var attack_duration: float = 2.0   # tempo do crescimento
@export var attack_max_radius: float = 30.0  # tamanho do ataque
@export var attack_color: Color = Color(1, 1, 1, 0.4)
@export var attack_damage: int = 2  # dano causado

var attack_timer: float = 0.0
var attack_progress: float = 0.0
var attacking: bool = false
var attack_area: Area2D
var shape: CircleShape2D

func _ready() -> void:
	attack_area = $AttackArea
	shape = $AttackArea/CollisionShape2D.shape
	attack_area.monitoring = false
	attack_area.monitorable = true

func _process(_delta):
	position = get_viewport().get_mouse_position()

	attack_timer += _delta

	if not attacking and attack_timer >= attack_interval:
		attacking = true
		attack_timer = 0.0
		attack_progress = 0.0
		attack_area.monitoring = true  # ativa detecção

	if attacking:
		attack_progress += _delta / attack_duration
		shape.radius = lerp(0.0, attack_max_radius, attack_progress)
		if attack_progress >= 1.0:
			attacking = false
			apply_attack_damage()  # 💥 dano no fim do ataque
			attack_area.monitoring = false
			shape.radius = 0.0

	queue_redraw()

func _draw():
	# círculo principal
	draw_circle(Vector2.ZERO, radius, color)

	# círculo de ataque (cresce, mas sem fade)
	if attacking:
		var current_radius = lerp(0.0, attack_max_radius, attack_progress)
		draw_circle(Vector2.ZERO, current_radius, attack_color)
		
		
func apply_attack_damage():
	var bodies = attack_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			body.take_damage(attack_damage)
			
	## procura inimigos na cena
	#var enemies = get_tree().get_nodes_in_group("enemies")
#
	#for enemy in enemies:
		#var dist = position.distance_to(enemy.position)
		#if dist <= radius:
			#enemy.take_damage(attack_damage)
