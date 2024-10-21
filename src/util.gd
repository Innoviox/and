class_name Util

static var tileScene = preload("res://scenes/tile.tscn")
static var itemScene = preload("res://scenes/item.tscn")


static func position(x: float, y: float) -> Vector2:
	return Vector2(50 + x * 100, 50 + y * 100)

static func make_tile(block: String, x: int, y: int) -> Tile:
	var tileNode = tileScene.instantiate()
	tileNode.img = block
	tileNode.x = x
	tileNode.y = y
	
	
	return tileNode
	
static func make_item(block: String, x: int, y: int) -> Item:
	var itemNode = itemScene.instantiate()
	itemNode.img = block
	itemNode.x = x 
	itemNode.y = y 
	
	return itemNode
