extends Node2D
class_name Tile

var x = 0
var y = 0
var on_board: bool # true => on board, false => in stack
var face_down: bool
var type: Common.TileType
var crumbling: bool
# todo: multiple people can stand on a gate
var rot = 0 # rotation * 90 = clockwise rotation in degrees

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_visible_deltas():
	var UP = Vector2(0, -1)
	var DOWN = Vector2(0, 1)
	var LEFT = Vector2(-1, 0)
	var RIGHT = Vector2(1, 0)
	
	var output = []
	match type:
		Common.TileType.NONE: 
			pass
		Common.TileType.START:
			if rot < 2:
				output.append(RIGHT)
			else:
				output.append(LEFT)
			if rot == 1 or rot == 2:
				output.append(DOWN)
			else:
				output.append(UP)
		Common.TileType.STRAIGHT:
			if rot % 2 == 0:
				output = [UP, DOWN]
			else:
				output = [LEFT, RIGHT]
		Common.TileType.T:
			output = [UP, DOWN, LEFT, RIGHT]
			output.erase([LEFT, UP, RIGHT, DOWN][rot])
		Common.TileType.FOUR, Common.TileType.WAX_EATER, Common.TileType.KEY, Common.TileType.GATE:
			output = [UP, DOWN, LEFT, RIGHT]
	return output
	
func get_visible_squares():
	var output = []
	for delta in get_visible_deltas():
		output.append(Common.clamp(Vector2(x, y) + delta))
	return output
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
