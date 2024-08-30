class_name CosmicHorrorEnemy
extends CharacterBody2D

@export var movement_speed: float = 100

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var wander_state: CosmicHorrorWanderState = $FiniteStateMachine/WanderState
@onready var chase_state: ChaseState = $FiniteStateMachine/ChaseState
@onready var cast: ShapeCast2D = $ShapeCast2D

var current_state: State = null
var orientation = OrientationHandler.ORIENTATION.DOWN


func _ready() -> void:
    setup_fsm()
    sprite.play("idle")


func setup_fsm():
    """
    Wander -> Chase
    """
    wander_state.found_player.connect(fsm.change_state.bind(chase_state))
    chase_state.lost_player.connect(fsm.change_state.bind(wander_state))

func find_player():
    return get_tree().get_current_scene().find_child("Player")

func _handle_orientation():
    var player = find_player()
    var angle_to_player = position.angle_to(player.global_position)
    
    if velocity == Vector2.ZERO:
        return
        
    orientation = OrientationHandler.get_orientation_from_direction(velocity)
    
    if current_state is CosmicHorrorWanderState:
        if orientation == OrientationHandler.ORIENTATION.UP:
            sprite.play("idle_top")
            sprite.flip_h = false
            cast.rotation_degrees = 180
        if orientation == OrientationHandler.ORIENTATION.DOWN:
            sprite.play("idle")
            sprite.flip_h = false
            cast.rotation_degrees = 0
        if orientation == OrientationHandler.ORIENTATION.LEFT:
            sprite.play("idle_side")
            sprite.flip_h = true
            cast.rotation_degrees = 90
        if orientation == OrientationHandler.ORIENTATION.RIGHT:
            sprite.play("idle_side")
            sprite.flip_h = false
            cast.rotation_degrees = 270


    elif current_state is ChaseState:
        if orientation == OrientationHandler.ORIENTATION.UP:
            sprite.play("attack_top")
            sprite.flip_h = false
        elif orientation == OrientationHandler.ORIENTATION.DOWN:
            sprite.play("attack")
            sprite.flip_h = false
        elif orientation == OrientationHandler.ORIENTATION.LEFT:
            sprite.play("attack_side")
            sprite.flip_h = true
        elif orientation == OrientationHandler.ORIENTATION.RIGHT:
            sprite.play("attack_side")
            sprite.flip_h = false

func _process(_delta: float) -> void:
    _handle_orientation()

func _on_finite_state_machine_state_changed(new_state: State) -> void:
    current_state = new_state
