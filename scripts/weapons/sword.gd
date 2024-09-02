class_name SwordWeapon
extends Node

@onready var player := $AnimationPlayer
@onready var animation_tree := $AnimationTree
@onready var hitbox := $HitBox


func attack(direction: Vector2):
    var state_machine = animation_tree["parameters/attack"]
    state_machine.travel(direction)


func _on_player_actions_attacking(direction: Vector2) -> void:
    attack(direction)
