"""
A hitbox is an area where damage is dealt to a character or enemy
It's usually attached to weapons, bullets, traps or bodies
"""
class_name HitBox
extends Area2D

@export var damage: int = 10
@export var knockback: float = 5
