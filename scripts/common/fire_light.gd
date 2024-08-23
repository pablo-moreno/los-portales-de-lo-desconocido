extends PointLight2D


@export var timer: Timer = null
@export var min_energy: float = 0
@export var max_energy: float = 1

func _ready() -> void:
    timer.start()

func _process(delta: float) -> void:
    if timer.is_stopped():
        energy = randf_range(min_energy, max_energy)
        timer.start()
