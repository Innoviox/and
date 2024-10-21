extends Node2D
class_name Tile

var x = 0
var y = 0
var on_board: bool # true => on board, false => in stack
var face_down: bool
var type: Common.TileType
var rot = 0 # rotation * 90 = clockwise rotation in degrees

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
