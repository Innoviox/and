extends Node
class_name Common

static var tileScene = preload("res://tile.tscn")


enum TileType {
	START,
	STRAIGHT,
	T,
	FOUR,
	WAX_EATER,
	KEY,
	GATE,
	NONE
}

static func make_start_tile() -> Tile:
	var tile = tileScene.instantiate()
	tile.on_board = false
	tile.face_down = false
	tile.type = TileType.START
	
	return tile
