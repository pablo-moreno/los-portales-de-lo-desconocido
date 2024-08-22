"""
Kudos:
https://www.reddit.com/r/godot/comments/17e8s6f/screencamera_shake_2dgodot_4/
"""
class_name CameraShake
extends Camera2D

# How quickly shaking will stop [0,1].
@export var decay := 0.8 
# Maximum displacement in pixels.
@export var max_offset := Vector2(100,75)
# Maximum rotation in radians (use sparingly).
@export var max_roll = 0.0
# The source of random values.
@export var noise : FastNoiseLite

# Value used to move through the noise
var noise_y = 0

# Current shake strength
var trauma := 0.0

# Trauma exponent. Use [2,3]
var trauma_pwr := 3

func _ready():
    randomize()
    noise.seed = randi()

func add_trauma(amount : float):
    trauma = min(trauma + amount, 1.0)

func _process(delta):
    if trauma:
        trauma = max(trauma - decay * delta, 0)
        shake()
        #optional
    elif offset.x != 0 or offset.y != 0 or rotation != 0:
        lerp(offset.x, 0.0, 1)
        lerp(offset.y, 0.0, 1)
        lerp(rotation, 0.0, 1)

func shake():
    var amt = pow(trauma, trauma_pwr)
    noise_y += 1
    rotation = max_roll * amt * noise.get_noise_2d(0, noise_y)
    offset.x = max_offset.x * amt * noise.get_noise_2d(1000, noise_y)
    offset.y = max_offset.y * amt * noise.get_noise_2d(2000, noise_y)
