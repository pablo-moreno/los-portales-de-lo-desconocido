class_name Tentacle
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cast: ShapeCast2D = $ShapeCast2D
@onready var hitbox_collision: CollisionShape2D = $HitBox/CollisionShape2D

func _ready() -> void:
    sprite.play("idle")

func _process(delta: float) -> void:
    if cast.is_colliding():
        sprite.play("attack")
        hitbox_collision.disabled = false
    else:
        sprite.play("idle")
        hitbox_collision.disabled = true
