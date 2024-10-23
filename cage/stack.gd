extends Node2D
class_name Stack

var tileScene = preload("res://tile.tscn")

var tiles = []

var tile_counts = {
	Common.TileType.STRAIGHT: 10,
	Common.TileType.T: 30,
	Common.TileType.FOUR: 12,
	Common.TileType.KEY: 6,
	Common.TileType.GATE: 4,
	Common.TileType.WAX_EATER: 12,
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tile_type in tile_counts:
		var count = tile_counts[tile_type]
		for i in range(count):
			var tile = tileScene.instantiate()
			tile.on_board = false
			tile.face_down = true
			tile.type = tile_type
			tile.crumbling = [Common.TileType.KEY, Common.TileType.STRAIGHT, Common.TileType.START].has(tile_type)
			
			tiles.append(tile)
	
	tiles.shuffle()
	
func pop() -> Tile:
	return tiles.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
