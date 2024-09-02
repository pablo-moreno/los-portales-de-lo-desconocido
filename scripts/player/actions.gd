class_name PlayerActions
extends Node

signal attacking(direction: Vector2)


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("attack"):
        attack()
    
    elif Input.is_action_just_pressed("pause"):
        pause()
    
    elif Input.is_action_just_pressed("heal"):
        heal()

func attack():
    var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    attacking.emit(direction)

func heal():
    pass

func pause():
    get_tree().paused = true
