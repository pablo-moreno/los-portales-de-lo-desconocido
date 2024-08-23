extends CanvasLayer

signal on_transition_finished

@onready var player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    color_rect.visible = false
    player.animation_finished.connect(_on_animation_finished)


func transition():
    color_rect.visible = true
    player.play("fade_to_black")

func _on_animation_finished(name) -> void:
    if name == "fade_to_black":
        player.play("fade_to_normal")
        on_transition_finished.emit()
    else:
        color_rect.visible = false
