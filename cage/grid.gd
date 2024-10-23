extends Node2D
class_name Grid

var tiles = [] # list of tiles

# lists of Vector2s
var possible = []
var revealed = []
var existing = []

var revealed_needs_recalc = false
var existing_needs_recalc = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make empty grid
	for i in range(5):
		var row = []
		for j in range(5):
			row.append(null)
		tiles.append(row)
		
func set_possible_from(x: int, y: int):
	possible = get_tile(x, y).get_visible_squares()

func set_all_possible():
	for i in range(5):
		for j in range(5):
			possible.append(Vector2(i, j))
			
func set_possible(new_possible: Array): 
	possible = new_possible.duplicate()
	
func remove_possible(x: int, y: int):
	possible.erase(Vector2(x, y))

func get_possible() -> Array:
	return possible.duplicate()
	
func get_revealed() -> Array:
	if !revealed_needs_recalc:
		return revealed
		
	get_existing() # recalculate if needed
	
	revealed = []
	
	for tile_pos in existing:
		var tile = get_tile(tile_pos.x, tile_pos.y)
		revealed.append_array(tile.get_visible_squares())
	
	return revealed
	
func get_existing() -> Array:
	if !existing_needs_recalc:
		return existing
		
	existing = []
	for i in range(5):
		for j in range(5):
			if tiles[i][j] != null:
				existing.append(Vector2(i, j))
	return existing
	
func kill(x: int, y: int):
	# kill the tile at x, y (it isn't supposed to be illuminated)
	existing_needs_recalc = true
	# todo add to discard
	tiles[y][x] = null
	
func get_tile(x: int, y: int):
	return tiles[y][x]
	
func place_tile(x: int, y: int, tile: Tile):
	existing_needs_recalc = true
	revealed_needs_recalc = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
