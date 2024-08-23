## Must be placed as a direct children of the character
class_name CameraLimitter
extends Node


@export var camera: Camera2D = null


func _ready():
    var layer: TileMapLayer = get_tree().get_current_scene().find_child("TileMapLayerWithLimits")
    
    if camera == null: return
    if layer == null: return

    var rect = layer.get_used_rect()
    var tile_size = layer.tile_set.tile_size
    
    var limit_right = (rect.size.x * tile_size.x)
    var limit_bottom = (rect.size.y * tile_size.y)
    
    camera.limit_bottom = limit_bottom
    camera.limit_right = limit_right
