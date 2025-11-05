extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: int = 1  # segundos
@export var max_enemies: int = 10

var spawn_timer: float = 0.0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func _process(delta: float) -> void:
	spawn_timer += delta

	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_enemy() -> void:
	if get_child_count() >= max_enemies:
		return  # evita lotar a tela

	var enemy: Node2D = enemy_scene.instantiate()
	var viewport_size: Vector2 = get_viewport_rect().size

	# posição aleatória dentro da tela
	var x: float = rng.randf_range(0, viewport_size.x)
	var y: float = rng.randf_range(0, viewport_size.y)
	enemy.position = Vector2(x, y)

	add_child(enemy)
