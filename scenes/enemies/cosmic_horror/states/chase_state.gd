class_name ChaseState
extends EnemyState

@export var cast: ShapeCast2D

signal lost_player


func _ready() -> void:
    assert(cast != null)
    set_physics_process(false)


func _physics_process(_delta) -> void:
    if not cast.is_colliding():
        lost_player.emit()

    var player = _get_player()
    _move_to(player.global_position)
