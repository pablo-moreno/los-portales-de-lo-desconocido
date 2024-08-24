class_name OrientationHandler
extends Node

enum ORIENTATION {
    UP,
    DOWN,
    LEFT,
    RIGHT
}

static func get_orientation_from_direction(input_direction: Vector2):
    if input_direction.x < 0 and abs(input_direction.x) > abs(input_direction.y):
        return ORIENTATION.LEFT

    elif input_direction.x > 0 and abs(input_direction.x) > abs(input_direction.y):
        return ORIENTATION.RIGHT
        
    elif input_direction.y < 0 and abs(input_direction.y) > abs(input_direction.x):
        return ORIENTATION.UP
        
    elif input_direction.y > 0 and abs(input_direction.y) > abs(input_direction.x):
        return ORIENTATION.DOWN

static func get_orientation_from_angle(angle: float):
    var deg_angle = rad_to_deg(angle)
    
    if 0 < deg_angle and deg_angle < 45:
        return OrientationHandler.ORIENTATION.UP
    elif 45 < deg_angle and deg_angle < 135:
        return OrientationHandler.ORIENTATION.RIGHT
    elif 135 < deg_angle and deg_angle < 225:
        return OrientationHandler.ORIENTATION.DOWN
    elif 225 < deg_angle and deg_angle < 315:
        return OrientationHandler.ORIENTATION.LEFT
    else:
        return OrientationHandler.ORIENTATION.UP
