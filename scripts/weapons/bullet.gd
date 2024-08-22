class_name Bullet
extends Area2D

@export var _hitbox: HitBox = null
@export var _timer: Timer = null
@export var _sprite: Sprite2D = null

@export var hitbox_collision_mask: int = 1   ## Hitbox collision mask, set this as the collision layer of the target to be detected
@export var hitbox_collision_layer: int = 1  ## Hitbox collision layer, set this as the collision mask of the target to be detected

@export var damage: int = 10          ## HitBox damage
@export var knockback: int = 5        ## Knockback applied
@export var speed = 100               ## Bullet speed
@export var lifetime: float = 1.5     ## Bullet lifetime

@export var texture: CompressedTexture2D = null  ## Sprite texture

func _check():
    assert(_hitbox != null)
    assert(_timer != null)
    assert(_sprite != null)


func _ready():
    _check()

    if texture != null:
        _sprite.texture = texture
    
    _hitbox.collision_layer = hitbox_collision_layer
    _hitbox.collision_mask = hitbox_collision_mask
    _hitbox.damage = damage
    _hitbox.knockback = knockback
    _timer.one_shot = true
    _timer.wait_time = lifetime
    _timer.start()

func _process(delta): 
    position += transform.x * speed * delta
    
    if _timer.is_stopped():
        queue_free()
