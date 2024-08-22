"""
A hurtbox is an area attached to the character or enemy that detects hitboxes
"""
class_name HurtBox
extends Area2D

@export var health: Health = null


signal hit
signal knockback_received(direction: Vector2, amount: float)


func _ready():
    assert(health != null)

    self.connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBox):
    # Check if the hitbox is a sibling
    var is_sibling: bool = hitbox.get_parent() == get_parent()

    if not hitbox or is_sibling:
        # Do nothing
        return

    hit.emit()

    var knockback_direction = self.global_position.direction_to(hitbox.global_position)
    health.take_damage(hitbox.damage)
    knockback_received.emit(knockback_direction, hitbox.knockback)
