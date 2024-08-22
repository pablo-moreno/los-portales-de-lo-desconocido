class_name Shaker
extends Node

@export var camera: CameraShake = null
@export var trauma: float = 0.2

func _ready() -> void:
    assert(camera != null)


func _process(_delta: float) -> void:
    if Input.is_action_pressed("shake"):
        camera.add_trauma(trauma)
