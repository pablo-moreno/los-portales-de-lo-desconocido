class_name PlayerActions
extends Node

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("attack"):
        attack()
    
    elif Input.is_action_just_pressed("pause"):
        pause()
    
    elif Input.is_action_just_pressed("heal"):
        heal()

func attack():
    pass

func heal():
    pass

func pause():
    get_tree().paused = true
