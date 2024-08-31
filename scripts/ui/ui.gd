class_name PlayerUI
extends CanvasLayer

@onready var you_died: RichTextLabel = $CenterContainer/YouDied
@onready var health_progress_bar = $Sprite2D/ProgressBar


func _ready() -> void:
    pass # Replace with function body.


func _on_health_death() -> void:
    you_died.visible = true
    get_tree().paused = true


func _on_health_change_health(new_health: int) -> void:
    if health_progress_bar != null:
        health_progress_bar.value = new_health

func _on_health_change_max_health(new_max_health: int) -> void:
    if health_progress_bar != null:
        health_progress_bar.max_value = new_max_health
