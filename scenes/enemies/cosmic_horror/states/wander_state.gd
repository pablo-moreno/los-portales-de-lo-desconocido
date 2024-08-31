class_name CosmicHorrorWanderState
extends EnemyState

@export var cast: ShapeCast2D

signal found_player


func _ready() -> void:
    assert(navigation_agent != null)
    set_physics_process(false)
    super._ready()


func _navigation_ended():
    var random_point = _get_random_point()
    set_movement_target(random_point)
    navigation_ended.emit()


func _get_random_point():
    if navigation_region == null:
        return Vector2.ZERO
    
    return NavigationServer2D.region_get_random_point(navigation_region.get_rid(), 1, false)


func _physics_process(_delta) -> void:    
    if cast.is_colliding():
        found_player.emit()
        return
    
    _move_to(Vector2.ZERO, 0.5)
