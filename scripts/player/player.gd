class_name Player
extends CharacterBody2D

enum ORIENTATION {
    UP,
    DOWN,
    LEFT,
    RIGHT
}

@export var SPEED: float = 300.0
@export var DASH_MODIFIER: float = 3.5
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var previous_orientation = ORIENTATION.DOWN
var previous_animation = "idle"
var is_dash = false


func _get_orientation_from_direction(input_direction: Vector2):
    if input_direction.x < 0 and abs(input_direction.x) > abs(input_direction.y):
        return ORIENTATION.LEFT

    elif input_direction.x > 0 and abs(input_direction.x) > abs(input_direction.y):
        return ORIENTATION.RIGHT
        
    elif input_direction.y < 0 and abs(input_direction.y) > abs(input_direction.x):
        return ORIENTATION.UP
        
    elif input_direction.y > 0 and abs(input_direction.y) > abs(input_direction.x):
        return ORIENTATION.DOWN

func _handle_animation(direction: Vector2) -> void:
    var orientation = _get_orientation_from_direction(direction)
    var new_animation = previous_animation
    
    # DASH
    if is_dash and previous_orientation == ORIENTATION.UP:
        animation.flip_h = false
        new_animation = "run_back"
    elif is_dash and previous_orientation == ORIENTATION.DOWN:
        animation.flip_h = false
        new_animation = "run"
    elif is_dash and previous_orientation == ORIENTATION.RIGHT:
        animation.flip_h = false
        new_animation = "dash"
    elif is_dash and previous_orientation == ORIENTATION.LEFT:
        animation.flip_h = true
        new_animation = "dash"

    # IDLE
    elif direction == Vector2.ZERO and previous_orientation == ORIENTATION.UP:
        animation.flip_h = false
        new_animation = "idle_back"
    elif direction == Vector2.ZERO and previous_orientation == ORIENTATION.DOWN:
        animation.flip_h = false
        new_animation = "idle"
    elif direction == Vector2.ZERO and previous_orientation == ORIENTATION.RIGHT:
        animation.flip_h = false
        new_animation = "idle_side"
    elif direction == Vector2.ZERO and previous_orientation == ORIENTATION.LEFT:
        animation.flip_h = true
        new_animation = "idle_side"

    # RUNNING
    elif orientation == ORIENTATION.UP:
        animation.flip_h = false
        new_animation = "run_back"
    elif orientation == ORIENTATION.DOWN:
        animation.flip_h = false
        new_animation = "run"
    elif orientation == ORIENTATION.RIGHT:
        animation.flip_h = false
        new_animation = "run_side"
    elif orientation == ORIENTATION.LEFT:
        animation.flip_h = true
        new_animation = "run_side"
    
    if is_dash and not animation.is_playing():
        is_dash = false
        return

    animation.play(new_animation)

    previous_orientation = orientation
    previous_animation = new_animation

func _physics_process(_delta: float) -> void:
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
    
    var speed = SPEED
    
    var is_axis = (direction.x == 0 or direction.y == 0)
    
    if not is_axis:
        is_dash = false
    
    if Input.is_action_just_pressed("dash") and is_axis:
        is_dash = true
    if Input.is_action_just_pressed("ui_accept"):
        TransitionScreen.transition()
        await TransitionScreen.on_transition_finished
    
    _handle_animation(direction)
    
    if direction == Vector2.ZERO:
        velocity = Vector2.ZERO
        is_dash = false
        return
    
    if is_dash:
        speed *= DASH_MODIFIER
    
    velocity = direction * speed
    move_and_slide()
